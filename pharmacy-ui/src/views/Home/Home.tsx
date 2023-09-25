// import Matrix from '../../components/Pharmacy/Metrics/Metrics';
import PharmacistList from '../../components/Pharmacy/PharmacistList/PharmacistList';
import PharmacyCard from '../../components/Pharmacy/PharmacyCard/PharmacyCard';
import PharmacyList from '../../components/Pharmacy/PharmacyList/PharmacyList';
import { PharmacyDrugDemand } from '../../components/metrics/PharmacyDrugDemand/PharmacyDrugDemand';
import './Home.scss';


const Home = () => {

  return (   
    <div className="wrapper">
    <div className="pharmacy"><PharmacyList/></div>
    <div className="pharmacyCard"><PharmacyCard/></div>
    <div className='pharmacyDrugDemand'><PharmacyDrugDemand/></div>
    <div className="pharmacist"><PharmacistList/></div>
    
  </div>
  )
}

export default Home