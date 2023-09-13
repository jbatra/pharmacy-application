import { Pharmacy } from './Pharmacy';
import { Pharmacist } from './Pharmacist';

export interface PharmacyState {
    loading: boolean;
    pharmacyList: Array<Pharmacy>;
    totalCount: number;
    error: string | undefined;
    selectedPharmacy: Pharmacy;
    pharmacistloading: boolean;
    pharmacistList: Array<Pharmacist>
    pharmacistCount: number;
    pharmacistError: string | undefined;
  }