import { Pharmacy } from './Pharmacy';

export interface PharmacyState {
    loading: boolean;
    pharmacyList: Array<Pharmacy>;
    totalCount: number;
    error: string | undefined;
    selectedPharmacy: Pharmacy;
  }