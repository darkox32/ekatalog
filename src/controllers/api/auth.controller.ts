import { Controller, Post, Body, Req, Put } from "@nestjs/common";
import { AdministratorService } from "src/services/administrator/administrator.service";
import { LoginAdministratorDto } from "src/dtos/auth/login.administrator.dto";
import { ApiResponse } from "misc/api.response.class";
import * as crypto from 'crypto';
import { LoginInfoDto } from "src/dtos/auth/login.info.dto";
import * as jwt from 'jsonwebtoken';
import { JwtDataDto } from "src/dtos/auth/jwt.data.dto";
import { Request } from "express";
import { SecretKey } from "config/secret.config";
import { UserRegistrationDto } from "src/dtos/user/user.registration.dto";
import { UserService } from "src/services/user/user.service";
import { LoginUserDto } from "src/dtos/user/user.login.dto";

@Controller('auth')
export class AuthController {

    constructor(
        public administratorService: AdministratorService,
        public userService: UserService,
    ) { }

    @Post('administrator/login') // POST http://localhost:3000/auth/login/
    async doAdministratorLogin(@Body() data: LoginAdministratorDto, @Req() req: Request): Promise<LoginInfoDto | ApiResponse> {
        const admin = await this.administratorService.getByUsername(data.username);
        if (!admin) {
            return new Promise(resolve => resolve(new ApiResponse('error', -3001)));
        }

        const passwordHash = crypto.createHash('sha512');
        passwordHash.update(data.password);
        const passwordHashString = passwordHash.digest('hex').toUpperCase();

        if (passwordHashString !== admin.passwordHash) {
            return new Promise(resolve => resolve(new ApiResponse('error', -3002)));
        }

        const jwtData = new JwtDataDto();
        jwtData.role = "administrator";
        jwtData.id = admin.administratorId;
        jwtData.identity = admin.username;

        let sada = new Date();
        sada.setDate(sada.getDate() + 300); // + 300 dana od sada
        const istekItemstamp = sada.getTime() / 1000.;
        jwtData.exp = istekItemstamp;

        jwtData.ip = req.ip.toString();
        jwtData.ua = req.headers['user-agent'];

        const token: string = jwt.sign(jwtData.toPlainObject(), SecretKey);

        const responseObject = new LoginInfoDto(
            admin.administratorId,
            admin.username,
            token
        );

        return new Promise(resolve => resolve(responseObject));
    }

    @Put('user/register')
    async userRegister(@Body() data: UserRegistrationDto) {
        return await this.userService.register(data);
    }

    @Post('user/login') // POST http://localhost:3000/auth/login/
    async doUserLogin(@Body() data: LoginUserDto, @Req() req: Request): Promise<LoginInfoDto | ApiResponse> {
        const user = await this.userService.getByEmail(data.email);

        if (!user) {
            return new Promise(resolve => resolve(new ApiResponse('error', -3001)));
        }

        const passwordHash = crypto.createHash('sha512');
        passwordHash.update(data.password);
        const passwordHashString = passwordHash.digest('hex').toUpperCase();

        if (passwordHashString !== user.passwordHash) {
            return new Promise(resolve => resolve(new ApiResponse('error', -3002)));
        }

        const jwtData: JwtDataDto = new JwtDataDto();
        jwtData.role = "user";
        jwtData.id = user.userId;
        jwtData.identity = user.email;

        let sada = new Date();
        sada.setDate(sada.getDate() + 300); // + 300 dana od sada
        const istekItemstamp = sada.getTime() / 1000.;
        jwtData.exp = istekItemstamp;

        jwtData.ip = req.ip.toString();
        jwtData.ua = req.headers['user-agent'];

        const token = jwt.sign(jwtData.toPlainObject(), SecretKey);

        return new LoginInfoDto(
            user.userId,
            user.email,
            token,
        );
    }

}