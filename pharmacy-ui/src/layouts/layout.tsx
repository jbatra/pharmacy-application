import Header from '../components/common/Header/Header';
import Footer from '../components/common/Footer/Footer';
import './Layout.scss';
import { ReactNode } from 'react';
import { SidebarNav } from '../components/common/SidebarNav/SidebarNav';


export const Layout = ({someComponent}: {someComponent: ReactNode}) => {
    return (
        <div className="layout">
            <Header/>
            <div style={{ display: "flex", height: "83vh" }}>
                <SidebarNav/>
                <section>{someComponent}</section>
            </div>
              <Footer/>
        </div>
    )
}