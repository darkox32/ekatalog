import { Injectable } from "@nestjs/common";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { Network } from "src/entities/network.entity";

@Injectable()
export class NetworkService extends TypeOrmCrudService<Network>{
    constructor(@InjectRepository(Network) private readonly network: Repository<Network>) {
        super(network);
    }
}