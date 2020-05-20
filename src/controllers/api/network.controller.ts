import { Controller } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { Network } from "src/entities/network.entity";
import { NetworkService } from "src/services/network/network.service";

@Controller('api/network')
@Crud({
    model: {
        type: Network
    },
    params: {
        id: {
            field: 'networkId',
            type: 'number',
            primary: true
        }
    },
    query: {
        join: {
            phoneNetworks: { eager: true },

        }
    }
})
export class NetworkController {
    constructor(
        public service: NetworkService
    ) { }
}