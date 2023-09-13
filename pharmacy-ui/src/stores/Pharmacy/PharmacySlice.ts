import {  createAction, createSlice } from "@reduxjs/toolkit";
import { RootState } from "../store";
import { fetchPharmacistReport, fetchPharmacyList, updatePharmacy } from "../../services/pharmacyService";
import { Pharmacy } from "./Pharmacy";
import { PharmacyState } from "./PharmacyState"

  const initialState: PharmacyState = {
    loading: false,
    pharmacyList: [],
    totalCount: 0,
    error: undefined,
    selectedPharmacy: {} as Pharmacy,
    pharmacistloading: false,
    pharmacistList: [],
    pharmacistCount: 0,
    pharmacistError: undefined
  }
  
  const pharmacySlice = createSlice({
    name: 'pharmacyList', 
    initialState,
    extraReducers: (builder) => {
      builder.addCase(fetchPharmacyList.pending, (state) => {
        state.loading = true;
      });
      builder.addCase(fetchPharmacyList.fulfilled, (state, action) => {
        state.loading = false;
        state.pharmacyList = action.payload.list;      
        state.totalCount = action.payload.totalCount;  
      });
      builder.addCase(fetchPharmacyList.rejected, (state, action) => {
        state.loading = false;
        state.pharmacyList = [];
        state.error = action.error.message;
      });      
      builder.addCase(pharmacySelection, (state, action) =>
      {
        state.selectedPharmacy = action.payload;
      });
      builder.addCase(updatePharmacy.fulfilled, (state, action) => {
        state.loading = false;
        state.pharmacyList = state.pharmacyList.map((pharmacy) => 
                                (pharmacy.pharmacyId === action.payload.pharmacyId) 
                                ? action.payload 
                                : pharmacy);
                                
        state.selectedPharmacy = action.payload;
      });
      builder.addCase(updatePharmacy.rejected, (state, action) => {
        state.error = action.error.message;
      }); 
      builder.addCase(fetchPharmacistReport.pending, (state) => {
        state.pharmacistloading = true;
      });
      builder.addCase(fetchPharmacistReport.fulfilled, (state, action) => {
       console.log(action.payload.totalCount);
       state.pharmacistloading = false;
        state.pharmacistList = action.payload.list;      
        state.pharmacistCount = action.payload.totalCount;          
      });
      builder.addCase(fetchPharmacistReport.rejected, (state, action) => {
        state.pharmacistloading = false;
        state.pharmacistList = [];
        state.pharmacistError = action.error.message;
      });    
    },
    reducers: {}
  })

export const pharmacySelector = (state: RootState) => state.pharmacyReducer;
export const getPharmacyList = (state: PharmacyState) => state.pharmacyList;
export const pharmacySelection = createAction<Pharmacy>('pharmacySelection');

export default pharmacySlice.reducer;