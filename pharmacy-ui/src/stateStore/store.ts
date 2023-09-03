import { configureStore } from '@reduxjs/toolkit';
//import { thunk, immutableStateInvariant, serializableStateInvariant,getDefaultMiddleware } from '@reduxjs/toolkit';
import pharmacyReducer  from './Pharmacy/PharmacySlice';


export const store = configureStore({
  reducer: {
    pharmacyReducer,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware({
      serializableCheck: {
        // Ignore these action types
        ignoredActions: ['your/action/type'],
        // Ignore these field paths in all actions
        ignoredActionPaths: ['meta.arg', 'payload.timestamp'],
        // Ignore these paths in the state
        ignoredPaths: ['items.dates'],
      },
    }),
});
export type AppDispatch = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>;