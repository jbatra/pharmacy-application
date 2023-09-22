import { LinearProgress } from "@mui/material";
import { useAppDispatch, useAppSelector } from "../../../stores/hooks"
import { DataGrid, GridColDef } from "@mui/x-data-grid";
import { useEffect } from "react";
import { fetchMostDemandedDrug } from "../../../services/metricsService";
//import { metricsReducer } from "../../../stores/Metrics/MetricsSlice"


export const MostDemandedDrug = () => {

    const { mostDemandedDrug,mdDrugLoading, mdDrugError } = useAppSelector((state) => { return  state.metricsReducer;});

    const dispatch = useAppDispatch();
    
    useEffect(() => {
        dispatch(fetchMostDemandedDrug());     
      }, []);

      if(!mostDemandedDrug || mostDemandedDrug.length === 0)
        return null;

    const columns: GridColDef[] = [
        { field: 'pharmacy', headerName:'Pharmacy', headerClassName:'columnHeader', width:1005,  flex: 1},
        { field: 'drug', headerName:'Drug', headerClassName:'columnHeader', width: 100,  flex: 1 },
        { field: 'quantitySold', headerName:'Quantity', headerClassName:'columnHeader', align:'center', type: 'number',width: 70,   flex: 0.5 },
        { field: 'sales', headerName:'Sales', headerAlign:"center", headerClassName:'columnHeader', align:'center', type: 'number',width: 100,   flex: 1 },
        ];
       
    return (
        <div>   
          {mdDrugLoading ? <div ><LinearProgress /></div> 
              : (!mdDrugLoading && !mostDemandedDrug || mostDemandedDrug.length === 0) ? <div>No Drug List</div>
              : mdDrugError ? <h2>{mdDrugError}</h2>     
              : 
              <div>      
                <div style={{textAlign:"center", fontWeight :"bold", color: "#245f89", fontSize: "20px"}}>Most demanded drug for Pharmacy</div>
          
                  <DataGrid style={{ height: 245}}
                    columns={columns}
                    rows={mostDemandedDrug}
                    getRowId={(row) => row.pharmacyId}         
                    rowCount={mostDemandedDrug.length}
                    rowHeight={30}    
                    columnHeaderHeight={40}  
                    pagination
                    hideFooterSelectedRowCount={true}                
                    pageSizeOptions={[5, 10, 15, 100]} 
                    sx={{                                            
                      m: 2,    
                      background:'#2b95d5',
                      color:"#FAF9F6",
                      boxShadow:3            
                    }}
                  />
                  
              </div>
          }
    </div>

    )
}