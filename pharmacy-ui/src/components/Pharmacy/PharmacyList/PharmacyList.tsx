import { useEffect, useState } from "react";
import { useAppDispatch, useAppSelector } from "../../../stateStore/hooks";
import {  pharmacySelection } from "../../../stateStore/Pharmacy/PharmacySlice";
import { DataGrid, GridColDef,GridPaginationModel, GridRowSelectionModel } from '@mui/x-data-grid';
import { Pharmacy } from "../../../stateStore/Pharmacy/Models/Pharmacy";
import { fetchPharmacyList, updatePharmacy } from "../../../services/pharmacyService";
import _ from 'lodash';
import { PaginationModel } from "../../../stateStore/PaginationModel";
import './PharmacyList.scss';


function PharmacyList () {
  const [paginationModel, setPaginationModel] = useState<PaginationModel>({page:0,pageSize:5})

  const dispatch = useAppDispatch();
  useEffect(() => {
    dispatch(fetchPharmacyList({page:paginationModel.page,pageSize:paginationModel.pageSize}));
  
  }, [paginationModel])

  const { pharmacyList, loading, error, totalCount} = useAppSelector((state) => {
    return state.pharmacyReducer;
  });
console.log(pharmacyList.length);
const columns: GridColDef[] = [
    { field: 'name', headerClassName:'header-bold', renderHeader: () => (<strong>{'Name'}</strong>),    width: 125, editable: true, flex: 1},
    { field: 'address',renderHeader: () => (<strong>{'Address'}</strong>), width: 125, editable: true, flex: 1 },
    { field: 'city',renderHeader: () => (<strong>{'City'}</strong>), width: 75, editable: true, flex: 0.75 },
    { field: 'state',renderHeader: () => (<strong>{'State'}</strong>), width: 70,  editable: true, flex: 0.5 },
    { field: 'zip', renderHeader: () => (<strong>{'Zip'}</strong>), width: 70, editable: true, flex: 0.75, },
    { field: 'rxFilledMtd',renderHeader: () => (<strong>{'Rx Filled'}</strong>), type: 'number', width: 80, editable: true, flex: 0.5 }
];

    const handleProcessRowUpdate = (updatedPharmacy: Pharmacy, originalPharmacy: Pharmacy) => {
            console.log(updatedPharmacy);
        if( !_.isEqual(updatedPharmacy, originalPharmacy) )
          dispatch(updatePharmacy(updatedPharmacy));
    return updatedPharmacy;
    }

    const handlePharmacySelectionChange = (selectedPharmacy: GridRowSelectionModel) => {
      const pharmacy = pharmacyList.find(pharmacy => pharmacy.pharmacyId === selectedPharmacy[0]) as Pharmacy;
          dispatch(pharmacySelection(pharmacy)); 
     }

     const handlePaginationModelChange = (changePageModel: GridPaginationModel) => {        
      if (paginationModel.pageSize !== changePageModel.pageSize) 
      {
        changePageModel.page = 0;
      }
      dispatch(pharmacySelection({} as Pharmacy)); 
      setPaginationModel(changePageModel);
 
  };

  return (         
    <div>
      
        {loading ? <div>Loading...</div>: error ? <h2>{error}</h2>:
                    
            <div style={{ width: '100%'}}>
              <DataGrid                
                getRowId={(row) => row.pharmacyId}
                rows={pharmacyList}
                columns={columns}
                editMode="row"
                processRowUpdate={handleProcessRowUpdate}
                onRowSelectionModelChange={handlePharmacySelectionChange}
                rowCount={totalCount} 
                pagination
                paginationMode="server"
                hideFooterSelectedRowCount={true}
                paginationModel={paginationModel}                               
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

export default PharmacyList;