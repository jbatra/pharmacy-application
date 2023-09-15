import Header from '../components/common/Header/Header';
import Footer from '../components/common/Footer/Footer';
import './Layout.scss';


const Layout = ({someComponent}: {someComponent: React.ReactNode}) =>  //(props: <Home/> | <PageNotFound/> 
{
  return (
    <div className='layout'>
        <Header/>
          {someComponent}
        <Footer/>
    </div>
  )
}

export default Layout