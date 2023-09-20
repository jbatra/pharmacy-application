import { useAppSelector, useAppDispatch } from "../../../stores/hooks";
import {useEffect } from "react";
import { GetTopFulfilledDrugsAtPharmacy } from '../../../services/metricsService';
import Paper from '@mui/material/Paper';
import { BarChart } from "@mui/x-charts";
import { LinearProgress } from "@mui/material";

export const PharmacyDrugDemand = () => {

    const dispatch = useAppDispatch();    
   
    const { selectedPharmacy } = useAppSelector((state) => { return state.pharmacyReducer});
    
    const { topDrugsFulfilled, topDrugsLoading, topDrugsError } = useAppSelector((state) => { return state.metricsReducer });

    useEffect(() => {
      if(selectedPharmacy && selectedPharmacy.pharmacyId )
        {
            dispatch(GetTopFulfilledDrugsAtPharmacy(selectedPharmacy.pharmacyId));   
        }  
      }, [selectedPharmacy]);

      if(!topDrugsFulfilled || topDrugsFulfilled.length === 0)
        return null;
    const mtdData = topDrugsFulfilled.map(s => s.quantitySold);
    const xLabels = topDrugsFulfilled.map(s=> s.drug);

    return (

    <>
        { topDrugsLoading ? <div style={{gridArea: 'pharmacyDrugDemand'}}><LinearProgress /></div> 
            : (!topDrugsLoading && !topDrugsFulfilled || topDrugsFulfilled.length === 0) ? <div style={{gridArea: 'pharmacyDrugDemand'}}>No Drug Report</div>
            : topDrugsError ? <h2>{topDrugsError}</h2>     
            : 
        
            
            <Paper style={{height:"300px"}}>
              {/* <h> Drug Demand Chart</h2> */}
            <div style={{textAlign:"center", fontWeight :"bold", color: "#245f89", fontSize: "20px", textDecoration:"underline"}}>
              Top Drugs fufilled by {selectedPharmacy.name}</div>
              <BarChart
                      width={400}
                      height={275}                
                      series={[{ data: mtdData, id: 'uvId', color: "#02B2AF"}]}
                      xAxis={[{ data: xLabels, scaleType: 'band' }]}
              />
            
            </Paper>
        
        } 
    </>
    )
}
