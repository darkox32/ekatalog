import { Injectable } from "@nestjs/common";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { Phone } from "src/entities/phone.entity";
import { ApiResponse } from "misc/api.response.class";
import { AddPhoneDto } from "dtos/phone/add.phone.dto";
import { PhonePrice } from "src/entities/phone-price.entity";
import { PhoneNetwork } from "src/entities/phone-network.entity";
import { EditPhoneDto } from "dtos/phone/edit.phone.dto";

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
        newPhone.os = data.os;
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

    async editFullPhone(phoneId: number, data: EditPhoneDto): Promise<Phone | ApiResponse> {
        const existingPhone: Phone = await this.findOne(phoneId, {
            relations: ['phonePrices', 'phoneNetworks']
        });

        if (!existingPhone) {
            return new ApiResponse('error', -5001, 'Phone not found.');
        }

        existingPhone.name = data.name;
        existingPhone.categoryId = data.categoryId;
        existingPhone.description = data.description;
        existingPhone.os = data.os;
        existingPhone.storageSize = data.storageSize;
        existingPhone.ramSize = data.ramSize;
        existingPhone.screenSize = data.screenSize;

        const savedPhone = await this.phone.save(existingPhone);
        if (!savedPhone) {
            return new ApiResponse('error', -5002, 'Could not save phone data.');
        }

        const newPriceString: string = Number(data.price).toFixed(2);

        const lastPrice = existingPhone.phonePrices[existingPhone.phonePrices.length - 1].price;
        const lastPriceString: string = Number(lastPrice).toFixed(2);

        if (newPriceString !== lastPriceString) {
            const newPhonePrice = new PhonePrice();
            newPhonePrice.phoneId = phoneId;
            newPhonePrice.price = data.price;

            const savedPhonePrice = await this.phonePrice.save(newPhonePrice);
            if (!savedPhonePrice) {
                return new ApiResponse('error', -5003, 'Could not save phone price.')
            }
        }

        if (data.networks !== null) {
            await this.phoneNetwork.remove(existingPhone.phoneNetworks);

            for (let network of data.networks) {
                let newPhoneNetwork: PhoneNetwork = new PhoneNetwork();
                newPhoneNetwork.phoneId = phoneId;
                newPhoneNetwork.networkId = network.networkId;
                newPhoneNetwork.band = network.band;

                await this.phoneNetwork.save(newPhoneNetwork);
            }
        }

        return await this.phone.findOne(phoneId, {
            relations: [
                "category",
                "networks",
                "phoneNetworks",
                "phonePrices"
            ]
        });

    }
}