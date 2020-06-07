import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
  ManyToMany,
  JoinTable,
} from "typeorm";
import { Category } from "./category.entity";
import { PhoneNetwork } from "./phone-network.entity";
import { PhonePrice } from "./phone-price.entity";
import { Photo } from "./photo.entity";
import { Network } from "./network.entity";
import * as Validator from 'class-validator';

@Index("fk_phone_category_id", ["categoryId"], {})
@Entity("phone")
export class Phone {
  @PrimaryGeneratedColumn({ type: "int", name: "phone_id", unsigned: true })
  phoneId: number;

  @Column("int", { name: "category_id", unsigned: true })
  categoryId: number;

  @Column("varchar", { name: "name", length: 128 })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(5, 128)
  name: string;

  @Column("enum", {
    name: "os",
    nullable: true,
    enum: ["Android", "iOS", "Windows", "Blackberry"],
  })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.IsIn(["Android", "iOS", "Windows", "Blackberry", null])
  os: "Android" | "iOS" | "Windows" | "Blackberry" | null;

  @Column("mediumtext", { name: "description", nullable: true })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(64, 10000)
  description: string | null;

  @Column("int", { name: "ram_size" })
  @Validator.IsNotEmpty()
  @Validator.IsNumber()
  ramSize: number;

  @Column("int", { name: "storage_size" })
  @Validator.IsNotEmpty()
  @Validator.IsNumber()
  storageSize: number;

  @Column("int", { name: "screen_size" })
  @Validator.IsNotEmpty()
  @Validator.IsNumber()
  screenSize: number;

  @Column("timestamp", {
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;

  @ManyToOne(() => Category, (category) => category.phones, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "category_id", referencedColumnName: "categoryId" }])
  category: Category;

  @OneToMany(() => PhoneNetwork, (phoneNetwork) => phoneNetwork.phone)
  phoneNetworks: PhoneNetwork[];

  @ManyToMany(type => Network, network => network.phones)
  @JoinTable({
    name: "phone_network",
    joinColumn: { name: "phone_id", referencedColumnName: "phoneId" },
    inverseJoinColumn: { name: "network_id", referencedColumnName: "networkId" }
  })
  networks: Network[];

  @OneToMany(() => PhonePrice, (phonePrice) => phonePrice.phone)
  phonePrices: PhonePrice[];

  @OneToMany(() => Photo, (photo) => photo.phone)
  photos: Photo[];
}