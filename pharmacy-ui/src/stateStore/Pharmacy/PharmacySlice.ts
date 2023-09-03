import {  createSlice } from "@reduxjs/toolkit";  //PayloadAction
import { RootState } from "../store";
//import { createAsyncThunk } from "@reduxjs/toolkit";
import { fetchPharmacyList } from "../../services/pharmacyService";
import { PharmacyState } from "./Pharmacy";



  const initialState: PharmacyState = {
    loading: false,
    pharmacyList: [],
    error: undefined,
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
        state.pharmacyList = action.payload;
      });
      builder.addCase(fetchPharmacyList.rejected, (state, action) => {
        state.loading = false;
        state.pharmacyList = [];
        state.error = action.error.message;
      });
      
      
      // updatePharmacy: (state, action) => {
          // add code 
      // },
    },
    reducers: {}
  })



export const pharmacySelector = (state: RootState) => state.pharmacyReducer;
export const getPharmacyList = (state: PharmacyState) => state.pharmacyList;
export default pharmacySlice.reducer;