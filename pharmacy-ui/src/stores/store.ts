import { configureStore } from '@reduxjs/toolkit';
import pharmacyReducer  from './Pharmacy/PharmacySlice';
import metricsReducer from './Metrics/MetricsSlice';


export const store = configureStore({
  reducer: {
    pharmacyReducer,
    metricsReducer
  },
});
export type AppDispatch = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>;