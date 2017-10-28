 /****** Object:  Stored Procedure dbo.RQVendAddrID_PV    Script Date: 9/4/2003 6:21:40 PM ******/

/****** Object:  Stored Procedure dbo.RQVendAddrID_PV    Script Date: 7/5/2002 2:44:46 PM ******/

/****** Object:  Stored Procedure dbo.RQVendAddrID_PV    Script Date: 1/7/2002 12:23:16 PM ******/

/****** Object:  Stored Procedure dbo.RQVendAddrID_PV    Script Date: 1/2/01 9:39:41 AM ******/

/****** Object:  Stored Procedure dbo.RQVendAddrID_PV    Script Date: 11/17/00 11:54:34 AM ******/

/****** Object:  Stored Procedure dbo.RQVendAddrID_PV    Script Date: 10/25/00 8:32:20 AM ******/

/****** Object:  Stored Procedure dbo.RQVendAddrID_PV    Script Date: 10/10/00 4:15:43 PM ******/

/****** Object:  Stored Procedure dbo.RQVendAddrID_PV    Script Date: 10/2/00 4:58:19 PM ******/

/****** Object:  Stored Procedure dbo.RQVendAddrID_PV    Script Date: 9/1/00 9:39:25 AM ******/

/****** Object:  Stored Procedure dbo.RQVendAddrID_PV    Script Date: 03/31/2000 12:21:24 PM ******/

/****** Object:  Stored Procedure dbo.RQVendAddrID_PV    Script Date: 2/2/00 12:18:21 PM ******/

/****** Object:  Stored Procedure dbo.RQVendAddrID_PV    Script Date: 12/17/97 10:49:13 AM ******/
Create Procedure RQVendAddrID_PV @Parm1 Varchar(10), @Parm2 Varchar(10) as
Select * From POAddress Where VendID = @Parm1 and OrdFromId Like @Parm2
Order By VendID, OrdFromId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQVendAddrID_PV] TO [MSDSL]
    AS [dbo];

