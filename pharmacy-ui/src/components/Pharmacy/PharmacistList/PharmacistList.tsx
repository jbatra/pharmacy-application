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

      if(!selectedPharmacy || !selectedPharmacy.name )//|| !pharmacistCount || pharmacistCount <= 0 )
            return null;

    console.log(pharmacistCount);
    
    const columns: GridColDef[] = [
        { field: 'pharmacist', renderHeader: () => (<strong>{'Pharmacist'}</strong>),    width: 75,  flex: 1},
        { field: 'drugName',renderHeader: () => (<strong>{'Drug Name'}</strong>), width: 50,  flex: 0.75 },
        { field: 'unitCount',renderHeader: () => (<strong>{'Unit Count'}</strong>), type: 'number',width: 70,   flex: 0.5 },
        { field: 'saleAmount', renderHeader: () => (<strong>{'Sales Amount'}</strong>), type: 'number', width: 70, flex: 0.75, },
       ];
       
  return (    
    <div>   
    {pharmacistloading ? <div style={{gridArea: 'pharmacist'}}><LinearProgress /></div> 
    : (!pharmacistloading && !pharmacistList || pharmacistCount === 0) ? <div style={{gridArea: 'pharmacist'}}>No Pharmacist</div>
    : pharmacistError ? <h2>{pharmacistError}</h2>     
    : 
    <div>      
    <div>PharmacistList</div>

        <DataGrid style={{ height: 240}}
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
            border: 3,
            borderColor: 'primary',
            background:'#aedaff'
            
          }}
        />
        
    </div>
        }
        </div>
  )
}

export default PharmacistList