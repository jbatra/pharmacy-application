import { configureStore } from '@reduxjs/toolkit';
import pharmacyReducer  from './Pharmacy/PharmacySlice';


export const store = configureStore({
  reducer: {
    pharmacyReducer
  },
});
export type AppDispatch = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>;