import { Column, Entity, Index, PrimaryGeneratedColumn } from "typeorm";

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
  email: string;

  @Column("varchar", {
    name: "password_hash",
    length: 128,
  })
  passwordHash: string;

  @Column("varchar", { name: "name", length: 64})
  name: string;

  @Column("varchar", { name: "surname", length: 64})
  surname: string;
}
