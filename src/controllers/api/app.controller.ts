import { Controller, Get, Param } from '@nestjs/common';
import { AdministratorService } from '../../services/administrator/administrator.service';

@Controller()
export class AppController {
  constructor(private administratorService: AdministratorService) { }

  @Get() // GET http://localhost:3000/
  getHomePage(): string {
    return 'Hello World!';
  }

}
