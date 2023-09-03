

export interface Pharmacy {
    pharmacyId: number;
    name: string;
    address?: string; 
    city?: string;
    state?: string;
    zip?: string;
    filledPrescriptionMtd?: number;
    createdDate: Date;
    updatedDate?: Date;
}

