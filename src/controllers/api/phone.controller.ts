import { Controller, Post, Body } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { PhoneService } from "src/services/phone/phone.service";
import { Phone } from "entities/phone.entity";
import { AddPhoneDto } from "dtos/phone/add.phone.dto";

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
    }
})
export class PhoneController {
    constructor(
        public service: PhoneService) { }

   @Post('createFull')     
   createFullPhone(@Body() data: AddPhoneDto){
       return this.service.createFullPhone(data);
   }
}