import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Telefon } from "./telefon.entity";

@Index("fk_telefon_price_telefon_id", ["telefonId"], {})
@Entity("telefon_price")
export class TelefonPrice {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "telefon_price_id",
    unsigned: true,
  })
  telefonPriceId: number;

  @Column({
    type: "int",
    name: "telefon_id",
    unsigned: true
  })
  telefonId: number;

  @Column({
    type: "decimal",
    unsigned: true,
    precision: 10,
    scale: 2,
  })
  price: string;

  @Column({
    type: "timestamp",
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;

  @ManyToOne(() => Telefon, (telefon) => telefon.telefonPrices, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "telefon_id", referencedColumnName: "telefonId" }])
  telefon: Telefon;
}
