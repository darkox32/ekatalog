import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Network } from "./network.entity";
import { Phone } from "./phone.entity";
import * as Validator from 'class-validator';


@Index("uq_phone_network_phone_id_network_id", ["phoneId", "networkId"], {
  unique: true,
})
@Index("fk_phone_network_network_id", ["networkId"], {})
@Entity("phone_network")
export class PhoneNetwork {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "phone_network_id",
    unsigned: true,
  })
  phoneNetworkId: number;

  @Column("int", { name: "phone_id", unsigned: true })
  phoneId: number;

  @Column("int", { name: "network_id", unsigned: true })
  networkId: number;

  @Column("varchar", { name: "band", length: 255 })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(1, 255)
  band: string;

  @ManyToOne(() => Network, (network) => network.phoneNetworks, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "network_id", referencedColumnName: "networkId" }])
  network: Network;

  @ManyToOne(() => Phone, (phone) => phone.phoneNetworks, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "phone_id", referencedColumnName: "phoneId" }])
  phone: Phone;
}
