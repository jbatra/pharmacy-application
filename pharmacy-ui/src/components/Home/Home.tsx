import PharmacyCard from '../Pharmacy/PharmacyCard/PharmacyCard';
import PharmacyList from '../Pharmacy/PharmacyList/PharmacyList';
import './Home.scss';
function Home() {

  return (
    
    <div className='home'>
    <div className='pharmacy-section'><PharmacyList/></div>
    <div className='pharmacy-detail'><PharmacyCard/></div>
    </div>
  )
}

export default Home