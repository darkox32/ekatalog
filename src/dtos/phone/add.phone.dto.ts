export class AddPhoneDto {
    name: string;
    categoryId: number;
    description: string;
    ramSize: number;
    storageSize: number;
    screenSize: number;
    price: string;
    networks: {
        networkId: number;
        band: string;
    }[];
}