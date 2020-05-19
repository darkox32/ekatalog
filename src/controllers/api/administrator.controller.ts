import { Controller, Get, Param, Put, Body, Post } from "@nestjs/common";
import { AdministratorService } from "src/services/administrator/administrator.service";
import { Administrator } from "src/entities/administrator.entity";
import { AddAdministratorDto } from "dtos/administrator/add.administrator.dto";
import { EditAdministratorDto } from "dtos/administrator/edit.administrator.dto";
import { ApiResponse } from "misc/api.response.class";
@Controller('api/administrator')
export class AdministratorController {
    constructor(
        private administratorService: AdministratorService
    ) { }

    @Get() // GET http://localhost:3000/api/administrator/
    getAll(): Promise<Administrator[]> {
        return this.administratorService.getAll();
    }

    @Get(':id') // GET http://localhost:3000/api/administrator/2/
    getById(@Param('id') administratorId: number): Promise<Administrator | ApiResponse> {
        return new Promise(async (resolve) => {
            let admin = await this.administratorService.getById(administratorId);

            if (admin === undefined) {
                resolve(new ApiResponse("error", -1002));
            }
            resolve(admin);
        })
    }

    @Put()
    add(@Body() data: AddAdministratorDto): Promise<Administrator | ApiResponse> {
        return this.administratorService.add(data);
    }

    @Post(':id')
    edit(@Param('id') id: number, @Body() data: EditAdministratorDto): Promise<Administrator | ApiResponse> {
        return this.administratorService.editById(id, data);
    }
}

