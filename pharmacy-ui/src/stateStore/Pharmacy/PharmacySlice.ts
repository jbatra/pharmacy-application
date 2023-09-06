import {  createAction, createSlice } from "@reduxjs/toolkit";
import { RootState } from "../store";
import { fetchPharmacyList, updatePharmacy } from "../../services/pharmacyService";
import { Pharmacy } from "./Models/Pharmacy";
import { PharmacyState } from "./Models/PharmacyState"

  const initialState: PharmacyState = {
    loading: false,
    pharmacyList: [],
    totalCount: 0,
    error: undefined,
    selectedPharmacy: {} as Pharmacy
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
        state.pharmacyList = action.payload.pharmacyList;      
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
        //state.loading = false;        
        state.error = action.error.message;
      });     
    },
    reducers: {}
  })

export const pharmacySelector = (state: RootState) => state.pharmacyReducer;
export const getPharmacyList = (state: PharmacyState) => state.pharmacyList;
export const pharmacySelection = createAction<Pharmacy>('pharmacySelection');

export default pharmacySlice.reducer;