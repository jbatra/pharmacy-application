import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Header from './layouts/Header/Header';
import Footer from './layouts/Footer/Footer';
import { PageNotFound } from './layouts/PageNotFound/PageNotFound';
import './App.scss'
import Home from './layouts/Home/Home';


function App() {
  return (
    <div className='app'>      
      <Router>
        <Header></Header>   
          <div className='container'>     
            <Routes>
              <Route path="/" element={<Home/>}/>             
              <Route path="error" element={<PageNotFound/>}/>
            </Routes> 
          </div>               
        <Footer></Footer>
      </Router>      
    </div>
  )
}

export default App
