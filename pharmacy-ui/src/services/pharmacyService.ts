import { createAsyncThunk } from "@reduxjs/toolkit";
import axios from "axios";
import { Pharmacy } from "../stores/Pharmacy/Pharmacy";
import { PaginationModel } from "../stores/PaginationModel"


export type pharma = {
  id: number,
  pagingParams: PaginationModel
}

export const fetchPharmacistReport =  createAsyncThunk(
  'fetchPharmacistReport',
  async (params: pharma, {rejectWithValue}) => {
    try {    
      //console.log(pagingParams);
      const response = await axios({
        method: 'POST',
        url: `/api/pharmacy/${params.id}/Pharmacist`,
        headers: {"Content-Type": "application/json"}, 
        data: params.pagingParams
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

  export const fetchPharmacyList =  createAsyncThunk(
    'fetchPharmacyList',
    async (pagingParams: PaginationModel, {rejectWithValue}) => {
      try {    
        //console.log(pagingParams);
        const response = await axios({
          method: 'POST',
          url: `/api/pharmacy`,
          headers: {"Content-Type": "application/json"}, 
          data: pagingParams
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
            data: Pharmacy
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

