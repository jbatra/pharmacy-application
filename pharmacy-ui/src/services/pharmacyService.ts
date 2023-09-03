import { createAsyncThunk } from "@reduxjs/toolkit";
import axios from "axios";


// export default axios.create({
//     baseURL: `/api`,
    
// });

export const fetchPharmacyList =  createAsyncThunk('fetchPharmacyList',
  async () => {
    return await axios.get('/api/pharmacy')
      .then(response => response.data)
  })

