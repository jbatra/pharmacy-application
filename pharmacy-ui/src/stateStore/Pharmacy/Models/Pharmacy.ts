

export interface Pharmacy {
    pharmacyId: number;
    name: string;
    address?: string; 
    city?: string;
    state?: string;
    zip?: string;
    rxFilledMtd?: number;
    createdDate: Date;
    updatedDate?: Date;
}

