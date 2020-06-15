import * as Validator from 'class-validator';
import { PhoneSearchNetworkComponentDto } from './phone.search.network.component.dto';
import { IsOptional } from 'class-validator';

export class PhoneSearchDto {

    @Validator.IsOptional()
    @Validator.IsString()
    keywords: string;

    @Validator.IsOptional()
    @Validator.IsPositive()
    @Validator.IsNumber({
        allowInfinity: false,
        allowNaN: false,
        maxDecimalPlaces: 0,
    })
    categoryId: number;

    @Validator.IsOptional()
    @Validator.IsString()
    os: string;

    @Validator.IsOptional()
    @Validator.IsPositive()
    @Validator.IsNumber({
        allowInfinity: false,
        allowNaN: false,
        maxDecimalPlaces: 0,
    })
    ramSize: number;
    
    @Validator.IsOptional()
    @Validator.IsPositive()
    @Validator.IsNumber({
        allowInfinity: false,
        allowNaN: false,
        maxDecimalPlaces: 0,
    })
    storageSize: number;

    @Validator.IsOptional()
    @Validator.IsPositive()
    @Validator.IsNumber({
        allowInfinity: false,
        allowNaN: false,
        maxDecimalPlaces: 0,
    })
    screenSize: number;

    networks: PhoneSearchNetworkComponentDto[];

    @Validator.IsOptional()
    @Validator.IsIn(['name', 'os', 'ramSize', 'storageSize', 'screenSize'])
    orderBy: 'name' | 'os' | 'ramSize' | 'storageSize' | 'screenSize';

    @Validator.IsOptional()
    @Validator.IsIn(['ASC', 'DESC'])
    orderDirection: 'ASC' | 'DESC';

    @Validator.IsOptional()
    @Validator.IsNumber({
        allowInfinity: false,
        allowNaN: false,
        maxDecimalPlaces: 0,
    })
    page: number;

    @Validator.IsOptional()
    @Validator.IsIn([5, 10, 25, 50, 75])
    itemsPerPage: 5 | 10 | 25 | 50 | 75;


}