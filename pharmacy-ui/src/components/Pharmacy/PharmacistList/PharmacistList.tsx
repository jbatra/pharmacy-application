import { DataGrid, GridColDef,GridPaginationModel } from '@mui/x-data-grid';
import { LinearProgress } from '@mui/material';
import { useAppDispatch, useAppSelector } from "../../../stores/hooks";
import { fetchPharmacistReport } from '../../../services/pharmacyService';
import { useEffect, useState } from "react";
import { PaginationModel } from '../../../stores/PaginationModel';

const PharmacistList = () => {

     const [pharmacistPaginationModel, setpharmacistPaginationModel] = useState<PaginationModel>({page:0,pageSize:5})
   
    function generateRandom() {
        var length = 8,
            charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
            retVal = "";
        for (var i = 0, n = charset.length; i < length; ++i) {
            retVal += charset.charAt(Math.floor(Math.random() * n));
        }
        return retVal;
    }
      const { pharmacistList, pharmacistCount,pharmacistError,selectedPharmacy,pharmacistloading } = useAppSelector((state) => { return state.pharmacyReducer; });
      const dispatch = useAppDispatch();

      useEffect(() => {                
        if(selectedPharmacy && selectedPharmacy.pharmacyId )
        {
            dispatch(fetchPharmacistReport({id: selectedPharmacy.pharmacyId,pagingParams: {page:pharmacistPaginationModel.page,pageSize:pharmacistPaginationModel.pageSize}}));
        }        
    }, [selectedPharmacy, pharmacistPaginationModel, dispatch]);

    const handlePaginationModelChange = (changePageModel: GridPaginationModel) => {
      if (pharmacistPaginationModel.pageSize !== changePageModel.pageSize) 
      {
        changePageModel.page = 0;
      }
      setpharmacistPaginationModel(changePageModel);
    }

      if(!selectedPharmacy || !selectedPharmacy.name )
            return null;
    
    const columns: GridColDef[] = [
        { field: 'pharmacist', headerName:'Pharmacist', headerClassName:'columnHeader', width: 75,  flex: 1},
        { field: 'drugName', headerName:'Drug', headerClassName:'columnHeader', width: 50,  flex: 0.75 },
        { field: 'unitCount', headerName:'Quantity', headerClassName:'columnHeader', align:'center', type: 'number',width: 70,   flex: 0.5 },
        { field: 'saleAmount', headerName:'Drug Sales($)', headerClassName:'columnHeader', align:'center', type: 'number', width: 70, flex: 0.75, },
       ];
       
  return (    
    <div>   
    {pharmacistloading ? <div style={{gridArea: 'pharmacist'}}><LinearProgress /></div> 
    : (!pharmacistloading && !pharmacistList || pharmacistCount === 0) ? <div style={{gridArea: 'pharmacist'}}>No Pharmacist Report</div>
    : pharmacistError ? <h2>{pharmacistError}</h2>     
    : 
    <>      
        <div style={{textAlign:"center", fontWeight :"bold", color: "#245f89", fontSize: "20px"}}>Pharmacist current month Sales</div>

            <DataGrid 
              columns={columns}
              rows={pharmacistList}
              getRowId={()=> generateRandom()}          
              rowCount={pharmacistCount}
              rowHeight={30}    
              columnHeaderHeight={40}  
              pagination
                    paginationMode="server"
                    hideFooterSelectedRowCount={true}
                    paginationModel={pharmacistPaginationModel}                               
                    onPaginationModelChange={handlePaginationModelChange}                
                    pageSizeOptions={[5, 10, 15]} 
              sx={{                                            
                m: 2,    
                background:'#2b95d5',
                color:"#FAF9F6", 
                height: 235,
                width:536                          
              }}
            />
            
        </>
        }
        </div>
        //style={{ height: 200, width:530}}
  )
}

export default PharmacistList