import { createAsyncThunk } from "@reduxjs/toolkit";
import axios from "axios";
import { Pharmacy } from "../stateStore/Pharmacy/Models/Pharmacy";
import { PaginationModel } from "../components/Pharmacy/PharmacyList/PharmacyList"

export type KnownError = {
  message: string;
  description: string;
  code: number | undefined;
};

// export const fetchPharmacyList =  createAsyncThunk(
//   'fetchPharmacyList',
//   async (_, {rejectWithValue}) => {
//       try {
//         const response = await axios.get('/api/pharmacy')
//           return response.data;
//       } 
//       catch (err) {   
//         const hasErrResponse = (err as { response: { [key: string]: string } }).response;
//         if (!hasErrResponse) {
//           throw err;
//         }
//         return rejectWithValue(hasErrResponse);
//       }
//   })

  export const fetchPharmacyList =  createAsyncThunk(
    'fetchPharmacyList',
    async (pagingParams: PaginationModel, {rejectWithValue}) => {
      try {    
        console.log(pagingParams);
        const response = await axios({
          method: 'POST',
          url: `/api/pharmacy`,
          headers: {"Content-Type": "application/json"}, 
          data: JSON.stringify(pagingParams)  
        });
        return response.data;
    } 
    catch (err) {   
      const hasErrResponse = (err as { response: { [key: string]: string } }).response;
      if (!hasErrResponse) {
        throw err;
      }
      return rejectWithValue(hasErrResponse);
    }
    })


  export const updatePharmacy = createAsyncThunk(
    "updatePharmacy",
    async (Pharmacy: Pharmacy, { rejectWithValue,}) => {
      try {    
          const response = await axios({
            method: 'put',
            url: `/api/pharmacy`,
            headers: {"Content-Type": "application/json"},          
            data: JSON.stringify(Pharmacy)
          });
          return response.data;
      } 
      catch (err) {   
        const hasErrResponse = (err as { response: { [key: string]: string } }).response;
        if (!hasErrResponse) {
          throw err;
        }
        return rejectWithValue(hasErrResponse);
      }
    }
  );  

