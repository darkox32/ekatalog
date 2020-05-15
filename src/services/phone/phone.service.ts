import { Injectable } from "@nestjs/common";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { Phone } from "entities/phone.entity";
import { ApiResponse } from "misc/api.response.class";
import { AddPhoneDto } from "dtos/phone/add.phone.dto";
import { PhonePrice } from "entities/phone-price.entity";
import { PhoneNetwork } from "entities/phone-network.entity";

@Injectable()
export class PhoneService extends TypeOrmCrudService<Phone>{
    constructor(
        @InjectRepository(Phone)
        private readonly phone: Repository<Phone>,

        @InjectRepository(PhonePrice)
        private readonly phonePrice: Repository<PhonePrice>,

        @InjectRepository(PhoneNetwork)
        private readonly phoneNetwork: Repository<PhoneNetwork>,

    ) {
        super(phone);
    }

    async createFullPhone(data: AddPhoneDto): Promise<Phone | ApiResponse> {
        let newPhone: Phone = new Phone();
        newPhone.name = data.name;
        newPhone.categoryId = data.categoryId;
        newPhone.description = data.description;
        newPhone.storageSize = data.storageSize;
        newPhone.ramSize = data.ramSize;
        newPhone.screenSize = data.screenSize;

        let savedPhone = await this.phone.save(newPhone);

        let newPhonePrice: PhonePrice = new PhonePrice();
        newPhonePrice.phoneId = savedPhone.phoneId;
        newPhonePrice.price = data.price;


        await this.phonePrice.save(newPhonePrice);

        for (let network of data.networks) {
            let newPhoneNetwork: PhoneNetwork = new PhoneNetwork();
            newPhoneNetwork.phoneId = savedPhone.phoneId;
            newPhoneNetwork.networkId = network.networkId;
            newPhoneNetwork.band = network.band;

            await this.phoneNetwork.save(newPhoneNetwork);
        }

        return await this.phone.findOne(savedPhone.phoneId, {
            relations: [
                "category",
                "networks",
                "phoneNetworks",
                "phonePrices"
            ]
        });
    }



}