import { useAppSelector, useAppDispatch } from "../../../stores/hooks";
import {useEffect } from "react";
import { GetTopFulfilledDrugsAtPharmacy } from '../../../services/metricsService';
import { BarChart } from "@mui/x-charts";
import { Box, Container, LinearProgress } from "@mui/material";

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

      if(!selectedPharmacy.name)  
        return null;
    const mtdData = topDrugsFulfilled.map(s => s.quantitySold);
    const xLabels = topDrugsFulfilled.map(s=> s.drug);

    return (
    <>
        { topDrugsLoading ? <div style={{gridArea: 'pharmacyDrugDemand'}}><LinearProgress /></div> 
            : (!topDrugsLoading && !topDrugsFulfilled || topDrugsFulfilled.length === 0) ? <div style={{gridArea: 'pharmacyDrugDemand'}}>No Drug Report</div>
            : topDrugsError ? <h2>{topDrugsError}</h2>     
            : 
        
            <Container maxWidth="sm">
            <Box sx={{ bgcolor: '#cfe8fc', height:"217px", alignContent:"center" }} >
            <div style={{textAlign:"center", fontWeight :"bold", color: "#245f89", fontSize: "20px", textDecoration:"underline"}}>
               Top Drugs fufilled by {selectedPharmacy.name}</div>
            <BarChart title="Test"
                      width={500}
                      height={220}                
                      series={[{ data: mtdData, id: 'uvId', color: "#02B2AF"}]}
                      xAxis={[{ data: xLabels, scaleType: 'band' }]}
                      yAxis={[{ tickMinStep:100, tickMaxStep:300, tickSize:250, labelFontSize:5, fill:"red",tickFontSize:4}]}
              />
              </Box>
          </Container>
        } 
    </>
    )
}
