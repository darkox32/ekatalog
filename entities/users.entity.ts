import { Column, Entity, Index, PrimaryGeneratedColumn } from "typeorm";

@Index("uq_user_email", ["email"], { unique: true })
@Entity("user")
export class User {
  @PrimaryGeneratedColumn({ type: "int", name: "user_id", unsigned: true })
  userId: number;

  @Column({
    type: "varchar",
    unique: true,
    length: 255,
  })
  email: string;

  @Column({
    type: "varchar",
    name: "password_hash",
    length: 128,
  })
  passwordHash: string;

  @Column({
    type: "varchar",
    length: 64,
  })
  name: string;

  @Column({
    type: "varchar",
    length: 64,
  })
  surname: string;
}
