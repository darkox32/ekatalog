import * as Validator from 'class-validator';
import { PhoneNetwrokComponentDto } from './phone.network.component.dto';

export class AddPhoneDto {
    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(5, 128)
    name: string;

    categoryId: number;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(64, 10000)
    description: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.IsIn(["Android", "iOS", "Windows", "Blackberry"])
    os: 'Android' | 'iOS' | 'Windows' | 'Blackberry';

    @Validator.IsNotEmpty()
    @Validator.IsNumber()
    ramSize: number;

    @Validator.IsNotEmpty()
    @Validator.IsNumber()
    storageSize: number;

    @Validator.IsNotEmpty()
    @Validator.IsNumber()
    screenSize: number;

    @Validator.IsNotEmpty()
    @Validator.IsPositive()
    @Validator.IsNumber({
        allowInfinity: false,
        allowNaN: false,
        maxDecimalPlaces: 2,
    })
    price: number;


    @Validator.IsArray()
    @Validator.ValidateNested({
        always: true,
    })
    networks: PhoneNetwrokComponentDto[];

}