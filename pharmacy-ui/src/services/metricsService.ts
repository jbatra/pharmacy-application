import { createAsyncThunk} from '@reduxjs/toolkit';
import axios  from "axios";



export const fetchPharmacySales = createAsyncThunk(    
    "fetchPharmacySales",
    async (_, {rejectWithValue}) => {
        
        try {    
            console.log("metrics service 1");
        const response = await axios({
            method: 'GET',
            url: `/api/metrics/PharmacySales`,
            headers: {"Content-Type": "application/json"}, 
        })
        console.log("metrics service 2");
        return response.data;
        } 
        catch (err) {   
            console.log("errorsales");
            console.log(err);
          const hasErrResponse = (err as { response: { [key: string]: string } }).response;
          if (!hasErrResponse) {
            throw err;
          }
          return rejectWithValue(hasErrResponse);
        }
    }
);

export const fetchMostDemandedDrug = createAsyncThunk(    
    "fetchMostDemandedDrug",
    async () => {
        console.log("metrics service mdd");
        const response = await axios({
            method: 'GET',
            url: `/api/metrics/MostDemandedDrug`,
            headers: {"Content-Type": "application/json"}, 
        })
        console.log("metrics service 2:");
        console.log(response.data);
        return response.data;
    }
);

export const GetTopFulfilledDrugsAtPharmacy = createAsyncThunk(    
    "GetTopFulfilledDrugsAtPharmacy",
    async (id: number) => {
        console.log("metrics service 1");
        const response = await axios({
            method: 'GET',
            url: `/api/metrics/GetTopDrugsAtPharmacy/${id}`,
            headers: {"Content-Type": "application/json"}, 
        })
        console.log("metrics service 2");
        return response.data;
    }
);



