import { useAppSelector } from '../../../stores/hooks';
import './PharmacyCard.scss';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Typography from '@mui/material/Typography';
import '../../../assets/colors.scss';

const PharmacyCard = () => {

  const { selectedPharmacy } = useAppSelector((state) => { return state.pharmacyReducer; });
  if(!selectedPharmacy || !selectedPharmacy.name )
      return null;

  return (    
    
  <div className='card-top'>
    <Card sx={{ width:"538px",height:"77px", align:"top", textAlign:"center",  color: "#FAF9F6", background:"rgba(5, 44, 68, 0.367)" }} >
      <CardContent>
      <Typography variant="h5"> {selectedPharmacy.name} 
        </Typography>
        <Typography variant="subtitle1">
        {selectedPharmacy.address}, {selectedPharmacy.city}, {selectedPharmacy.state} - {selectedPharmacy.zip}
        </Typography>
      </CardContent>
    </Card>

    </div>

  );
}

 export default PharmacyCard
