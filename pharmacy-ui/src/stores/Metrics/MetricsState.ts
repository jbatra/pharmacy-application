import { MostDemandedDrug } from "./MostDemandedDrug";
import { PharmacySales } from "./PharmacySales";


export interface MetricsState {
    pharmacySales: Array<PharmacySales>,
    loading: boolean,
    error: string | undefined,
    mostDemandedDrug: Array<MostDemandedDrug>,
    mdDrugLoading: boolean,
    mdDrugError: string | undefined,
    topDrugsFulfilled: Array<MostDemandedDrug>,
    topDrugsLoading: boolean,
    topDrugsError: string | undefined,
}