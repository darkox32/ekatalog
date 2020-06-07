import { Column, Entity, Index, PrimaryGeneratedColumn } from "typeorm";
import * as Validator from 'class-validator';

@Index("uq_user_email", ["email"], { unique: true })
@Entity("user", { schema: "ekatalog" })
export class User {
  @PrimaryGeneratedColumn({ type: "int", name: "user_id", unsigned: true })
  userId: number;

  @Column("varchar", {
    name: "email",
    unique: true,
    length: 255,
  })
  @Validator.IsNotEmpty()
  @Validator.IsEmail({
    allow_ip_domain: false,
    allow_utf8_local_part: true,
    require_tld: true,
  })
  email: string;

  @Column("varchar", {
    name: "password_hash",
    length: 128,
  })
  @Validator.IsNotEmpty()
  @Validator.IsHash('sha512')
  passwordHash: string;

  @Column("varchar", { name: "name", length: 64 })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  name: string;

  @Column("varchar", { name: "surname", length: 64 })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  surname: string;
}
