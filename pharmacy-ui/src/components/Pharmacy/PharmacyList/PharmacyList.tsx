import { useEffect } from "react";
import { useAppDispatch, useAppSelector } from "../../../stateStore/hooks";
import { pharmacySelector  } from "../../../stateStore/Pharmacy/PharmacySlice";
import { DataGrid, GridColDef } from '@mui/x-data-grid';
import { PageNotFound } from "../../../layouts/PageNotFound/PageNotFound";
import { Pharmacy } from "../../../stateStore/Pharmacy/Pharmacy";
import { fetchPharmacyList } from "../../../services/pharmacyService";
import './PharmacyList.scss';

function PharmacyList () {

  const selectedPharmacyList= useAppSelector(pharmacySelector);
  const dispatch = useAppDispatch()
  useEffect(() => {
    dispatch(fetchPharmacyList())
  }, [])

const columns: GridColDef[] = [
    { field: 'name',    headerName: 'Name',    width: 200, editable: true, flex: 2 },
    { field: 'address', headerName: 'Address', width: 150, editable: true, flex: 1.5 },
    { field: 'city',    headerName: 'City',    width: 150, editable: true, flex: 1 },
    { field: 'state',   headerName: 'State',   width: 70,  editable: true, flex: 1 },
    { field: 'zip',     headerName: 'Zip',  width: 70, editable: true, flex: 0.5, type: 'number' },
    { field: 'filledPrescriptionMTD', headerName: 'RX Filled(MTD)', type: 'number', editable: true, flex: 0.5 }
];

    const handleProcessRowUpdate = (updatedPharmacy: Pharmacy, originalPharmacy: Pharmacy) => {
            // add code to update pharmacy

      return updatedPharmacy;
    }

  return (
    <div>
    <div className="ph-list">               
      
      <div>
      {selectedPharmacyList.loading && <div>Loading...</div>}
      {selectedPharmacyList.error && <div><PageNotFound/></div>}   
      {/* Error: {selectedPharmacyList.error} */}
      {!selectedPharmacyList.loading && selectedPharmacyList.pharmacyList.length ? (       
        <div>
        <h2>List of Pharmacies</h2>
        <div style={{ height: 350, width: '100%' }}>
          <DataGrid
            getRowId={(row) => row.pharmacyId}
            rows={selectedPharmacyList.pharmacyList}
            columns={columns}
            editMode="row"
            processRowUpdate={handleProcessRowUpdate}
            //onProcessRowUpdateError={onProcessRowUpdateError}
          />            
      </div>
      </div>
      ) : null}
  
       </div>       
    </div>  
      
    </div>
   
  )
}

export default PharmacyList;