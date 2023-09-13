CREATE DATABASE [PharmacyManagementStore]
 ON  PRIMARY 
( NAME = N'PharmacyManagementStore', FILENAME = N'C:\SQLExpress\DATA\PharmacyManagementStore.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PharmacyManagementStore_log', FILENAME = N'C:\SQLExpress\DATA\PharmacyManagementStore_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO