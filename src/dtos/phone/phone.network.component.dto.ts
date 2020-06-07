import * as Validator from 'class-validator';

export class PhoneNetwrokComponentDto {
    networkId: number;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    band: string;
}