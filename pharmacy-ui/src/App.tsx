import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import { PageNotFound } from './components/common/PageNotFound/PageNotFound';
import './App.scss'
import Layout from './layouts/layout';


function App() {
  return (
    <div className='app'>      
      <Router>   
          <div className='container'>     
            <Routes>
              <Route path="/" element={<Layout/>}/>             
              <Route path="error" element={<PageNotFound/>}/>
            </Routes> 
          </div> 
      </Router>      
    </div>
  )
}

export default App
