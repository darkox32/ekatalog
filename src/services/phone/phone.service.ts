import { Injectable } from "@nestjs/common";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { Phone } from "entities/phone.entity";

@Injectable()
export class PhoneService extends TypeOrmCrudService<Phone>{
    constructor(@InjectRepository(Phone) private readonly category: Repository<Phone>) {
        super(category);
    }
}