import { useAppSelector } from '../../../stores/hooks';
import './PharmacyCard.scss';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import  CardHeader  from '@mui/material/CardHeader';
import Typography from '@mui/material/Typography';
import '../../../assets/colors.scss';

const PharmacyCard = () => {

  const { selectedPharmacy } = useAppSelector((state) => { return state.pharmacyReducer; });
  if(!selectedPharmacy || !selectedPharmacy.name )
      return null;

  return (    
  <div className='.card-top'>
    <Card sx={{ minWidth: 275, color: "white", background:"#2b95d5" }} >
      <CardHeader title={selectedPharmacy.name} sx={{ fontFamily: 'sans-serif;' }}/>    
      <CardContent>
        <Typography variant="subtitle2" gutterBottom>
        {selectedPharmacy.address}
        </Typography>
        <Typography variant="subtitle2" component="div">
        {selectedPharmacy.city}, {selectedPharmacy.state} - {selectedPharmacy.zip}
        </Typography>
        <Typography variant="subtitle1"> Rx Filled MTD : {selectedPharmacy.rxFilledMtd} 
        </Typography>
      </CardContent>
    </Card>

    </div>

  );
}

 export default PharmacyCard
