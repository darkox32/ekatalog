import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
  ManyToMany,
  JoinTable,
} from "typeorm";
import { PhoneNetwork } from "./phone-network.entity";
import { Phone } from "./phone.entity";
import * as Validator from 'class-validator';

@Index("uq_network_name", ["name"], { unique: true })
@Entity("network")
export class Network {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "network_id",
    unsigned: true
  })
  networkId: number;

  @Column("varchar", {
    name: "name",
    unique: true,
    length: 32,
  })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(1, 32)
  name: string;

  @OneToMany(() => PhoneNetwork, (phoneNetwork) => phoneNetwork.network)
  phoneNetworks: PhoneNetwork[];

  @ManyToMany(type => Phone, phone => phone.networks)
  @JoinTable({
    name: "phone_network",
    joinColumn: { name: "network_id", referencedColumnName: "networkId" },
    inverseJoinColumn: { name: "phone_id", referencedColumnName: "phoneId" }
  })
  phones: Phone[];


}
