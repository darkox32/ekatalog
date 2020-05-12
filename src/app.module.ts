import { Module } from '@nestjs/common';
import { AppController } from './controllers/api/app.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DatabaseConfiguration } from 'config/database.configuration';
import { Administrator } from 'entities/administrator.entity';
import { AdministratorService } from './services/administrator/administrator.service';
import { AdministratorController } from './controllers/api/administrator.controller';
import { Category } from 'entities/category.entity';
import { Network } from 'entities/network.entity';
import { PhoneNetwork } from 'entities/phone-network.entity';
import { PhonePrice } from 'entities/phone-price.entity';
import { Phone } from 'entities/phone.entity';
import { Photo } from 'entities/photo.entity';
import { User } from 'entities/users.entity';
import { CategoryController } from './controllers/api/category.controller';
import { CateogryService } from './services/category/category.service';
import { PhoneService } from './services/phone/phone.service';
import { PhoneController } from './controllers/api/phone.controller';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mariadb', // Ako koristite MySQL, napisite mysql
      host: DatabaseConfiguration.hostname,
      port: 3306,
      username: DatabaseConfiguration.username,
      password: DatabaseConfiguration.password,
      database: DatabaseConfiguration.database,
      entities: [
        Administrator,
        Category,
        Network,
        PhoneNetwork,
        PhonePrice,
        Phone,
        Photo,
        User
      ]
    }),
    TypeOrmModule.forFeature([
      Administrator,
      Category,
      Phone,
      PhonePrice,
      PhoneNetwork,

    ])
  ],
  controllers: [
    AppController,
    AdministratorController,
    CategoryController,
    PhoneController,
  ],
  providers: [
    AdministratorService,
    CateogryService,
    PhoneService,
  ],
})
export class AppModule { }
