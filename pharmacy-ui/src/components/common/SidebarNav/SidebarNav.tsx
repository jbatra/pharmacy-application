import { Sidebar, SubMenu, Menu, MenuItem } from "react-pro-sidebar";
import './SidebarNav.scss'
import { useState } from "react";
import { Link } from "react-router-dom";

import MenuRoundedIcon from "@mui/icons-material/MenuRounded";
import GridViewRoundedIcon from "@mui/icons-material/GridViewRounded";
//import ReceiptRoundedIcon from "@mui/icons-material/ReceiptRounded";
import BarChartRoundedIcon from "@mui/icons-material/BarChartRounded";
import TimelineRoundedIcon from "@mui/icons-material/TimelineRounded";
import BubbleChartRoundedIcon from "@mui/icons-material/BubbleChartRounded";
//import WalletRoundedIcon from "@mui/icons-material/WalletRounded";
import AccountBalanceRoundedIcon from "@mui/icons-material/AccountBalanceRounded";
import SavingsRoundedIcon from "@mui/icons-material/SavingsRounded";
//import MonetizationOnRoundedIcon from "@mui/icons-material/MonetizationOnRounded";
import SettingsApplicationsRoundedIcon from "@mui/icons-material/SettingsApplicationsRounded";
import AccountCircleRoundedIcon from "@mui/icons-material/AccountCircleRounded";
import ShieldRoundedIcon from "@mui/icons-material/ShieldRounded";
import NotificationsRoundedIcon from "@mui/icons-material/NotificationsRounded";
import LogoutRoundedIcon from "@mui/icons-material/LogoutRounded";
import LocalShippingIcon from '@mui/icons-material/LocalShipping';
import LocalPharmacyIcon from '@mui/icons-material/LocalPharmacy';
import MedicationIcon from '@mui/icons-material/Medication';


export const SidebarNav = () => {

    const [collapsed, setCollapsed] = useState(false);
    const toggled = false;
    const handleCollapsedChange = () => {
    setCollapsed(!collapsed);
    };

    return (
        <Sidebar className={`${toggled ? "toggled" : ""}`}
            style={{ height: "100%", position: "relative" }}
            collapsed={collapsed}
            toggled={toggled}  
            width="215px"
   collapsedWidth="4.5rem"
            >        
            <Menu>
                {collapsed ? (
                    <MenuItem
                    icon={<MenuRoundedIcon />}
                    onClick={handleCollapsedChange}
                    ></MenuItem>
                ) : (
                    <MenuItem
                    suffix={<MenuRoundedIcon />}
                    onClick={handleCollapsedChange}
                    >
                    <div
                        style={{
                        padding: "9px",
                        fontWeight: "bold",
                        fontSize: 18,
                        letterSpacing: "1px",
                        color: "#245f89",
                        }}
                    >
                        Nuvem®
                    </div>
                    </MenuItem>
            )}
            <hr />
            </Menu>
            <Menu style={{color:'#245f89', fontWeight: "bold"}}>         
                <MenuItem icon={<GridViewRoundedIcon />}> Dashboard  </MenuItem>
                <MenuItem component={<Link to="/" className="link" />} icon={<LocalPharmacyIcon />}> Pharmacy </MenuItem>
            <SubMenu label="Drug" icon={<MedicationIcon />}>
                <MenuItem component={<Link to="drug" className="link" />} icon={<AccountBalanceRoundedIcon />}> Most Demanded </MenuItem>
                <MenuItem icon={<SavingsRoundedIcon />}>Most Profitable</MenuItem>
            </SubMenu>
                <MenuItem icon={<LocalShippingIcon />}> Delivery   </MenuItem>
            <SubMenu label="Charts" icon={<BarChartRoundedIcon />}>
                <MenuItem component={<Link to="chart" className="link" />} icon={<TimelineRoundedIcon />}> Monthly Sales </MenuItem>
                <MenuItem icon={<BubbleChartRoundedIcon />}> Yearly Sales</MenuItem>
            </SubMenu>            
            <SubMenu label="Settings" icon={<SettingsApplicationsRoundedIcon />}>
                <MenuItem icon={<AccountCircleRoundedIcon />}> Account </MenuItem>
                <MenuItem icon={<ShieldRoundedIcon />}> Privacy </MenuItem>
                <MenuItem icon={<NotificationsRoundedIcon />}>
                    Notifications
                </MenuItem>
            </SubMenu>
                <MenuItem icon={<LogoutRoundedIcon />}> Logout </MenuItem>
            </Menu>
        </Sidebar>
    )


}