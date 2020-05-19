import { Module, NestModule, MiddlewareConsumer } from '@nestjs/common';
import { AppController } from './controllers/api/app.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DatabaseConfiguration } from 'config/database.configuration';
import { Administrator } from 'src/entities/administrator.entity';
import { AdministratorService } from './services/administrator/administrator.service';
import { AdministratorController } from './controllers/api/administrator.controller';
import { Category } from 'src/entities/category.entity';
import { Network } from 'src/entities/network.entity';
import { PhoneNetwork } from 'src/entities/phone-network.entity';
import { PhonePrice } from 'src/entities/phone-price.entity';
import { Phone } from 'src/entities/phone.entity';
import { Photo } from 'src/entities/photo.entity';
import { User } from 'src/entities/users.entity';
import { CategoryController } from './controllers/api/category.controller';
import { CateogryService } from './services/category/category.service';
import { PhoneService } from './services/phone/phone.service';
import { PhoneController } from './controllers/api/phone.controller';
import { AuthController } from './controllers/api/auth.controller';
import { AuthMiddleware } from './middlewares/auth.middleware';
import { PhotoService } from './services/photo/photo.service';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',
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
      Network,
      PhoneNetwork,
      PhonePrice,
      Phone,
      Photo,
      User

    ])
  ],
  controllers: [
    AppController,
    AdministratorController,
    CategoryController,
    PhoneController,
    AuthController,

  ],
  providers: [
    AdministratorService,
    CateogryService,
    PhoneService,
    PhotoService,
  ],

  exports: [
    AdministratorService,

  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(AuthMiddleware)
      .exclude('auth/*')
      .forRoutes('api/*');


  }
}
