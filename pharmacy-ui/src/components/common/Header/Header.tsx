import { Link } from 'react-router-dom';
import "./Header.scss";

const Header = () => {
    return (
        <div className="header">
            <Link to="/">
            <div className='logo'>Pharmacy Management System®</div>
            </Link>
            <div className='rightSideDiv'>Environment: {JSON.stringify(import.meta.env.MODE)}</div>        
        </div>
        )        
};

export default Header;