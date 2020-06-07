import { Controller, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { Network } from "src/entities/network.entity";
import { NetworkService } from "src/services/network/network.service";
import { RoleCheckerGuard } from "misc/role.checker.guard";
import { AllowToRoles } from "misc/allow.to.roles.descriptor";

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
    },
    routes: {
        only: [
            "createOneBase",
            "createManyBase",
            "updateOneBase",
            "getManyBase",
            "getOneBase",

        ],
        createOneBase: {
            decorators: [
                UseGuards(RoleCheckerGuard),
                AllowToRoles('administrator'),
            ]
        },
        createManyBase: {
            decorators: [
                UseGuards(RoleCheckerGuard),
                AllowToRoles('administrator'),
            ]
        },
        updateOneBase: {
            decorators: [
                UseGuards(RoleCheckerGuard),
                AllowToRoles('administrator'),
            ]
        },
        getManyBase: {
            decorators: [
                UseGuards(RoleCheckerGuard),
                AllowToRoles('administrator', 'user'),
            ]
        },
        getOneBase: {
            decorators: [
                UseGuards(RoleCheckerGuard),
                AllowToRoles('administrator', 'user'),
            ]
        },


    }

})
export class NetworkController {
    constructor(
        public service: NetworkService
    ) { }
}