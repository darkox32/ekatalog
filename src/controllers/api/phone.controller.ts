import { Controller, Post, Body, Param, UseInterceptors, UploadedFile, Req, Delete, Patch, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { PhoneService } from "src/services/phone/phone.service";
import { Phone } from "src/entities/phone.entity";
import { AddPhoneDto } from "src/dtos/phone/add.phone.dto";
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { StorageConfig } from "config/storage.config";
import { PhotoService } from "src/services/photo/photo.service";
import { Photo } from "src/entities/photo.entity";
import { ApiResponse } from "misc/api.response.class";
import * as fileType from "file-type";
import * as fs from 'fs';
import * as sharp from 'sharp';
import { EditPhoneDto } from "src/dtos/phone/edit.phone.dto";
import { AllowToRoles } from "misc/allow.to.roles.descriptor";
import { RoleCheckerGuard } from "misc/role.checker.guard";


@Controller('api/phone')
@Crud({
    model: {
        type: Phone
    },
    params: {
        id: {
            field: 'phoneId',
            type: 'number',
            primary: true
        }
    },
    query: {
        join: {
            category: { eager: true },
            photos: { eager: true },
            phonePrices: { eager: true },
            phoneNetworks: { eager: true },
            networks: { eager: true }
        }
    },
    routes: {
        exclude: [
            'updateOneBase',
            'replaceOneBase',
            'deleteOneBase',

        ],
    }
})
export class PhoneController {
    constructor(
        public service: PhoneService,
        public photoService: PhotoService,

    ) { }

    @Post('createFull')
    @UseGuards(RoleCheckerGuard)
    @AllowToRoles('administrator')
    createFullPhone(@Body() data: AddPhoneDto) {
        return this.service.createFullPhone(data);
    }

    @Patch(':id')
    @UseGuards(RoleCheckerGuard)
    @AllowToRoles('administrator')
    editFullArticle(@Param('id') id: number, @Body() data: EditPhoneDto) {
        return this.service.editFullPhone(id, data);
    }

    @Post(':id/uploadPhoto/') // post /api/article/:id/uploadPhoto
    @UseGuards(RoleCheckerGuard)
    @AllowToRoles('administrator')
    @UseInterceptors(
        FileInterceptor('photo', {
            storage: diskStorage({
                destination: StorageConfig.photo.destination,
                filename: (req, file, callback) => {
                    let original: string = file.originalname;

                    let normalized = original.replace(/\s+/g, '-');
                    normalized = normalized.replace(/[^A-z0-9\.\-]/g, '');
                    let sada = new Date();
                    let datePart = '';
                    datePart += sada.getFullYear();
                    datePart += (sada.getMonth() + 1).toString();
                    datePart += sada.getDate().toString();

                    let randomPart: string =
                        new Array(10)
                            .fill(0)
                            .map(e => (Math.random() * 9).toFixed(0).toString())
                            .join('');


                    let fileName = datePart + '-' + randomPart + '-' + normalized;

                    fileName = fileName.toLocaleLowerCase();
                    callback(null, fileName);
                }
            }),
            fileFilter: (req, file, callback) => {
                if (!file.originalname.toLowerCase().match(/\.(jpg|png)$/)) {
                    req.fileFilterError = 'Bad file extension!'
                    callback(null, false);
                    return;
                }

                if (!(file.mimetype.includes('jpeg') || file.mimetype.includes('png'))) {
                    req.fileFilterError = 'Bad file content!'
                    callback(null, false);
                    return;
                }

                callback(null, true);
            },

            limits: {
                files: 1,
                fileSize: StorageConfig.photo.maxSize
            }

        })
    )
    async uploadPhoto(
        @Param('id') phoneId: number,
        @UploadedFile() photo,
        @Req() req
    ): Promise<Photo | ApiResponse> {

        if (req.fileFilterError) {
            return new ApiResponse('error', -4002, req.fileFilterError);
        }

        if (!photo) {
            return new ApiResponse('error', -4002, 'File not uploaded!');
        }

        const fileTypeResult = await fileType.fromFile(photo.path);
        if (!fileTypeResult) {
            fs.unlinkSync(photo.path);

            return new ApiResponse('error', -4002, 'Cannot detect file type');
        }

        const realMimeType = fileTypeResult.mime;
        if (!(realMimeType.includes('jpeg') || realMimeType.includes('png'))) {
            fs.unlinkSync(photo.path);

            return new ApiResponse('error', -4002, 'Bad file content type!');
        }

        await this.createResizedImage(photo, StorageConfig.photo.resize.thumb)
        await this.createResizedImage(photo, StorageConfig.photo.resize.small)

        const newPhoto: Photo = new Photo();
        newPhoto.phoneId = phoneId;
        newPhoto.imagePath = photo.filename;

        const savedPhoto = await this.photoService.add(newPhoto);
        if (!savedPhoto) {
            return new ApiResponse('error', -4001);
        }
        return savedPhoto;

    }

    async createResizedImage(photo, resizeSettings) {
        const originalFilePath = photo.path;
        const fileName = photo.filename;

        const destinationFilePath =
            StorageConfig.photo.destination +
            resizeSettings.directory +
            fileName;
        await sharp(originalFilePath)
            .resize({
                fit: 'cover',
                width: resizeSettings.width,
                height: resizeSettings.height,
            })
            .toFile(destinationFilePath);

    }

    @Delete(':phoneId/deletePhoto/:photoId')
    @UseGuards(RoleCheckerGuard)
    @AllowToRoles('administrator')
    public async deletePhoto(
        @Param('phoneId') phoneId: number,
        @Param('photoId') photoId: number,
    ) {
        const photo = await this.photoService.findOne({
            phoneId: phoneId,
            photoId: photoId
        });

        if (!photo) {
            return new ApiResponse('error', -4004, 'Photo not found');
        }

        try {
            fs.unlinkSync(StorageConfig.photo.destination + photo.imagePath);
            fs.unlinkSync(StorageConfig.photo.destination + StorageConfig.photo.resize.thumb.directory + photo.imagePath);
            fs.unlinkSync(StorageConfig.photo.destination + StorageConfig.photo.resize.small.directory + photo.imagePath);
        } catch (e) { }
        const deleteResult = await this.photoService.deleteById(photoId);

        if (deleteResult.affected === 0) {
            return new ApiResponse('error', -4004, 'Photo not found');
        }

        return new ApiResponse('ok', 0, 'Photo deleted');

    }

}