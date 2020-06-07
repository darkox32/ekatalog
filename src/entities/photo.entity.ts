import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Phone } from "./phone.entity";
import * as Validator from 'class-validator';

@Index("uq_photo_image_path", ["imagePath"], { unique: true })
@Index("fk_photo_phone_id", ["phoneId"], {})
@Entity("photo")
export class Photo {
  @PrimaryGeneratedColumn({ type: "int", name: "photo_id", unsigned: true })
  photoId: number;

  @Column("int", { name: "phone_id", unsigned: true })
  phoneId: number;

  @Column("varchar", {
    name: "image_path",
    unique: true,
    length: 128,
  })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  imagePath: string;

  @ManyToOne(() => Phone, (phone) => phone.photos, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "phone_id", referencedColumnName: "phoneId" }])
  phone: Phone;
}
