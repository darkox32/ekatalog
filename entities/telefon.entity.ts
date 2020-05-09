import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Photo } from "./photo.entity";
import { Category } from "./category.entity";
import { TelefonPrice } from "./telefon-price.entity";

@Index("fk_telefon_category_id", ["categoryId"], {})
@Entity("telefon")

export class Telefon {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "telefon_id",
    unsigned: true
  })
  telefonId: number;

  @Column({
    type: "varchar",
    length: 128,
  })
  name: string;

  @Column({
    type: "int",
    name: "category_id",
    unsigned: true
  })
  categoryId: number;

  @Column({
    type: "varchar",
    length: 32
  })
  resolution: string;

  @Column({
    type: "varchar",
    length: 32
  })
  ram: string;

  @Column({
    type: "int",
    name: "storage"
  })
  storage: number;

  @Column({
    type: "set",
    nullable: true,
    enum: ["GSM", "3G", "LTE", "4G"],
    default: () => "3G"
  })
  standard: ("GSM" | "3G" | "LTE" | "4G")[] | null;

  @Column({
    type: "text"
  })
  description: string | null;

  @Column({
    type: "timestamp",
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;

  @OneToMany(() => Photo, (photo) => photo.telefon)
  photos: Photo[];

  @ManyToOne(() => Category,
    (category) => category.telefons, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "category_id", referencedColumnName: "categoryId" }])
  category: Category;

  @OneToMany(() => TelefonPrice, (telefonPrice) => telefonPrice.telefon)
  telefonPrices: TelefonPrice[];
}
