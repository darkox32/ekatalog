import { NestMiddleware, HttpException, HttpStatus, Injectable } from "@nestjs/common";
import { NextFunction, Request, Response } from "express";
import { AdministratorService } from "src/services/administrator/administrator.service";
import * as jwt from "jsonwebtoken";
import { JwtAdministratorDto } from "dtos/auth/jwt.data.administrator.dto";
import { SecretKey } from "config/secret.config";

@Injectable()
export class AuthMiddleware implements NestMiddleware {
    use(req: Request, res: Response, next: NextFunction) {
        if (!req.headers.authorization) {
            throw new HttpException('The token does not exist!', HttpStatus.UNAUTHORIZED);
        }

        const tokenParts = req.headers.authorization.split(' ');
        if (tokenParts.length !== 2) {
            throw new HttpException('The token does not exist!', HttpStatus.UNAUTHORIZED);
        }

        const token = tokenParts[1];
        let jwtData: JwtAdministratorDto;
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

        const sada = new Date();
        if (jwtData.exp < sada.getTime() / 1000.) {
            throw new HttpException('The token has expired!', HttpStatus.UNAUTHORIZED);
        }

        next();
    }

}