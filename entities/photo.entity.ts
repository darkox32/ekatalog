import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Telefon } from "./telefon.entity";

@Index("uq_photo_image_path", ["imagePath"], { unique: true })
@Index("fk_photo_telefon_id", ["telefonId"], {})
@Entity("photo")
export class Photo {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "photo_id",
    unsigned: true
  })
  photoId: number;

  @Column({
    type: "int",
    name: "telefon_id",
    unsigned: true
  })
  telefonId: number;

  @Column({
    type: "varchar",
    name: "image_path",
    unique: true,
    length: 128,
  })
  imagePath: string;

  @ManyToOne(() => Telefon, (telefon) => telefon.photos, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "telefon_id", referencedColumnName: "telefonId" }])
  telefon: Telefon;
}
