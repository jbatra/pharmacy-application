// import Matrix from '../../components/Pharmacy/Metrics/Metrics';
import PharmacistList from '../../components/Pharmacy/PharmacistList/PharmacistList';
import PharmacyCard from '../../components/Pharmacy/PharmacyCard/PharmacyCard';
import PharmacyList from '../../components/Pharmacy/PharmacyList/PharmacyList';
import { PharmacyDrugDemand } from '../../components/metrics/PharmacyDrugDemand/PharmacyDrugDemand';
import './Home.scss';


const Home = () => {

  return (   
    <div className="wrapper">
    <div className="box1"><PharmacyList/></div>
    <div className="box2"><PharmacyCard/></div>
    <div className="box3"><PharmacistList/></div>
    <div className='box4'><PharmacyDrugDemand/></div>
  </div>
  )
}

export default Home