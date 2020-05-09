import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { PhoneNetwork } from "./phone-network.entity";

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
  name: string;

  @OneToMany(() => PhoneNetwork, (phoneNetwork) => phoneNetwork.network)
  phoneNetworks: PhoneNetwork[];
}
