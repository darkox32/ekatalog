import * as Validator from 'class-validator';

export class UserRegistrationDto {

    @Validator.IsNotEmpty()
    @Validator.IsEmail({
        allow_ip_domain: false,
        allow_utf8_local_part: true,
        require_tld: true,
    })
    email: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(6, 128)
    password: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    name: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    surname: string;
}