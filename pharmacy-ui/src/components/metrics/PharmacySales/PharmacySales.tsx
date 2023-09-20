import { useAppSelector, useAppDispatch } from "../../../stores/hooks";
import {useEffect } from "react";
import { fetchPharmacySales } from '../../../services/metricsService';
import Paper from '@mui/material/Paper';
import { BarChart } from "@mui/x-charts";

export const PharmacySales = () => {

    const dispatch = useAppDispatch();
    const { pharmacySales, loading, error } = useAppSelector((state) => { return state.metricsReducer });
    
    useEffect(() => {
        dispatch(fetchPharmacySales());     
      }, []);

      if(!pharmacySales || pharmacySales.length === 0)
        return null;
    const mtdData = pharmacySales.map(s => s.totalSalesMTD);
    const ytdData = pharmacySales.map(s => s.totalSalesYTD);
    const xLabels = pharmacySales.map(s=> s.pharmacy.substring(0,9));

    const month = pharmacySales[0].saleMonth;
    const year = pharmacySales[0].saleYear.toString();

    return (
       <div style= {{paddingTop: "50px", paddingLeft:"50px"}}>
        <Paper>
        <div style={{textAlign:"center", fontWeight :"bold", color: "#245f89", fontSize: "20px", textDecoration:"underline"}}>Pharmacy Sales Chart</div>
         <BarChart
                width={500}
                height={300}                
                series={[                    
                    { data: ytdData, label: year, id: 'uvId', color: "rgb(96, 0, 155)"},
                    { data: mtdData, label: month, id: 'pvId', color: "#02B2AF" },
                ]}
                xAxis={[{ data: xLabels, scaleType: 'band' }]}
        />
        </Paper>
       </div>
        
    )
}
