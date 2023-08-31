export interface Pharmacy {
    pharmacyId: number;
    name: string;
    city?: string;
    state?: string;
    zip?: string;
    filledPrescriptionMTD?: number;
    createdDate: Date;
    updatedDate?: Date;
}

export interface PharmacyState {
    loading: boolean;
    pharmacyList: Array<Pharmacy>;
    error: string | undefined;
  }