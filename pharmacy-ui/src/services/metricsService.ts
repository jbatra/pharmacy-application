import { createAsyncThunk} from '@reduxjs/toolkit';
import axios  from "axios";



export const fetchPharmacySales = createAsyncThunk(    
    "fetchPharmacySales",
    async () => {
        console.log("metrics service 1");
        const response = await axios({
            method: 'GET',
            url: `/api/PharmacySales`,
            headers: {"Content-Type": "application/json"}, 
        })
        console.log("metrics service 2");
        return response.data;
    }
);

export const fetchMostDemandedDrug = createAsyncThunk(    
    "fetchMostDemandedDrug",
    async () => {
        console.log("metrics service mdd");
        const response = await axios({
            method: 'GET',
            url: `/api/MostDemandedDrug`,
            headers: {"Content-Type": "application/json"}, 
        })
       // console.log("metrics service 2");
        return response.data;
    }
);

export const GetTopFulfilledDrugsAtPharmacy = createAsyncThunk(    
    "GetTopFulfilledDrugsAtPharmacy",
    async (id: number) => {
        console.log("metrics service 1");
        const response = await axios({
            method: 'GET',
            url: `/api/GetTop5DrugsAtPharmacy/${id}`,
            headers: {"Content-Type": "application/json"}, 
        })
        console.log("metrics service 2");
        return response.data;
    }
);



