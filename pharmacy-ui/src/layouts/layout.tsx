import Header from '../components/common/Header/Header';
import Footer from '../components/common/Footer/Footer';
import Home from '../components/Home/Home';
import "../assets/colors.scss";

const layout = () => {
  return (
    <div>
        <Header/>   
          <div className='container'><Home/></div>               
        <Footer/>
    </div>
  )
}

export default layout