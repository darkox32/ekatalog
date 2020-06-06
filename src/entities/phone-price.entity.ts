import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Phone } from "./phone.entity";

@Index("fk_phone_price_phone_id", ["phoneId"], {})
@Entity("phone_price")
export class PhonePrice {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "phone_price_id",
    unsigned: true,
  })
  phonePriceId: number;

  @Column("int", { name: "phone_id", unsigned: true })
  phoneId: number;

  @Column("decimal", {
    name: "price",
    unsigned: true,
    precision: 10,
    scale: 2,
  })
  price: number;

  @Column("timestamp", {
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;

  @ManyToOne(() => Phone, (phone) => phone.phonePrices, {
    onDelete: "RESTRICT",
    onUpdate: "RESTRICT",
  })
  @JoinColumn([{ name: "phone_id", referencedColumnName: "phoneId" }])
  phone: Phone;
}
