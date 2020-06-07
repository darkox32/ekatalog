export class EditPhoneDto {
    name: string;
    categoryId: number;
    description: string;
    os: 'Android' | 'iOS' | 'Windows' | 'Blackberry';
    ramSize: number;
    storageSize: number;
    screenSize: number;
    price: number;
    networks: {
        networkId: number;
        band: string;
    }[] | null;
}