import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import { PageNotFound } from './views/PageNotFound/PageNotFound';
import './App.scss'
import Layout from './layouts/Layout';
import Home from './views/Home/Home';


function App() {
  return (
    <div className='app'>      
      <Router>   
          <div className='container'>     
            <Routes>
              <Route path="/" element={<Layout someComponent={<Home/>}/>}/>
              <Route path="error" element={<Layout someComponent={<PageNotFound/>}/>}/>
            </Routes> 
          </div> 
      </Router>      
    </div>
  )
}

export default App
