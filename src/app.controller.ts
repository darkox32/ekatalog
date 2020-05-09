import { Controller, Get, Param } from '@nestjs/common';
import { Administrator } from 'entities/administrator.entity';
import { AdministratorService } from './services/administrator/administrator.service';

@Controller()
export class AppController {
  constructor(private administratorService: AdministratorService) { }

  @Get() // GET http://localhost:3000/
  getHomePage(): string {
    return 'Hello World!';
  }

  @Get('api/administrator') // GET http://localhost:3000/api/administrator/
  getAllAdministrators(): Promise<Administrator[]> {
    return this.administratorService.getAll();
  }

  @Get('api/administrator/:id') // GET http://localhost:3000/api/administrator/2/
  getSingleAdministrator(@Param('id') id: number): Promise<Administrator> {
    return this.administratorService.getById(id);
  }
}
