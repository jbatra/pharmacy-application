import {  createSlice}  from '@reduxjs/toolkit';
import { MetricsState } from './MetricsState';
import { fetchMostDemandedDrug, fetchPharmacySales, GetTopFulfilledDrugsAtPharmacy } from '../../services/metricsService';
import { RootState } from '../store';


const initialState: MetricsState = {
    loading: false,
    pharmacySales: [],
    error: undefined,
    mdDrugLoading: false,
    mostDemandedDrug: [],
    mdDrugError: undefined,
    topDrugsLoading: false,
    topDrugsFulfilled: [],
    topDrugsError: undefined,
}


const metricsSlice = createSlice({
    name: "metrics",
    initialState,
    reducers: {},
    extraReducers: (builder) => {
        builder.addCase(fetchPharmacySales.pending, (state) => {
            state.loading = true;
        });
        builder.addCase(fetchPharmacySales.fulfilled, (state, action) =>{
            state.loading = false;
            state.pharmacySales = action.payload;
        });
        builder.addCase(fetchPharmacySales.rejected, (state, action) => {
            state.loading = false;
            state.pharmacySales = [];
            state.error = action.error.message;
        });
        builder.addCase(fetchMostDemandedDrug.pending, (state) => {
            state.mdDrugLoading = true;
        });
        builder.addCase(fetchMostDemandedDrug.fulfilled, (state, action) =>{
            state.mdDrugLoading = false;
            state.mostDemandedDrug = action.payload;
        });
        builder.addCase(fetchMostDemandedDrug.rejected, (state, action) => {
            state.mdDrugLoading = false;
            state.mostDemandedDrug = [];
            state.mdDrugError = action.error.message;
        });
        builder.addCase(GetTopFulfilledDrugsAtPharmacy.pending, (state) => {
            state.topDrugsLoading = true;
        });
        builder.addCase(GetTopFulfilledDrugsAtPharmacy.fulfilled, (state, action) =>{
            state.topDrugsLoading = false;
            state.topDrugsFulfilled = action.payload;
        });
        builder.addCase(GetTopFulfilledDrugsAtPharmacy.rejected, (state, action) => {
            state.topDrugsLoading = false;
            state.topDrugsFulfilled = [];
            state.topDrugsError = action.error.message;
        });
        
    }
});

export const metricsSelector = (state: RootState) => state.metricsReducer;
export const getPharmacyList = (state: MetricsState) => state.pharmacySales;


export default metricsSlice.reducer;