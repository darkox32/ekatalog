import { NestMiddleware, HttpException, HttpStatus, Injectable } from "@nestjs/common";
import { NextFunction, Request, Response } from "express";
import { AdministratorService } from "src/services/administrator/administrator.service";
import * as jwt from "jsonwebtoken";
import { JwtDataDto } from "src/dtos/auth/jwt.data.dto";
import { SecretKey } from "config/secret.config";
import { UserService } from "src/services/user/user.service";

@Injectable()
export class AuthMiddleware implements NestMiddleware {
    constructor(
        public administratorService: AdministratorService,
        public userService: UserService,
    ) { }

    async use(req: Request, res: Response, next: NextFunction) {
        if (!req.headers.authorization) {
            throw new HttpException('The token does not exist!', HttpStatus.UNAUTHORIZED);
        }

        const tokenParts = req.headers.authorization.split(' ');
        if (tokenParts.length !== 2) {
            throw new HttpException('The token does not exist!', HttpStatus.UNAUTHORIZED);
        }

        const token = tokenParts[1];
        let jwtData: JwtDataDto;
        try {
            jwtData = jwt.verify(token, SecretKey);

            if (!jwtData) {
                throw new HttpException('The token is not valid!', HttpStatus.UNAUTHORIZED);
            }
        } catch (e) {
            throw new HttpException('The token is not valid!', HttpStatus.UNAUTHORIZED);
        }

        if (jwtData.ip !== req.ip) {
            throw new HttpException('The token is not valid!', HttpStatus.UNAUTHORIZED);
        }

        if (jwtData.ua !== req.headers['user-agent']) {
            throw new HttpException('The token is not valid!', HttpStatus.UNAUTHORIZED);
        }

        if (jwtData.role === "administrator") {
            const administrator = await this.administratorService.getById(jwtData.id);
            if (!administrator) {
                throw new HttpException('Accout not found', HttpStatus.UNAUTHORIZED);
            }
        } else if (jwtData.role === "user") {
            const user = await this.userService.getById(jwtData.id);
            if (!user) {
                throw new HttpException('Accout not found', HttpStatus.UNAUTHORIZED);
            }
        }


        const trenutniTimestamp = new Date().getTime() / 1000;
        if (trenutniTimestamp >= jwtData.exp) {
            throw new HttpException('The token has expired!', HttpStatus.UNAUTHORIZED);
        }
        
        req.token = jwtData;

        next();
    }

}