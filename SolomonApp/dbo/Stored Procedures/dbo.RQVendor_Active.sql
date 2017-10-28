 /****** Object:  Stored Procedure dbo.RQVendor_Active    Script Date: 9/4/2003 6:21:40 PM ******/

/****** Object:  Stored Procedure dbo.RQVendor_Active    Script Date: 7/5/2002 2:44:46 PM ******/

/****** Object:  Stored Procedure dbo.RQVendor_Active    Script Date: 1/7/2002 12:23:16 PM ******/

/****** Object:  Stored Procedure dbo.RQVendor_Active    Script Date: 1/2/01 9:39:41 AM ******/

/****** Object:  Stored Procedure dbo.RQVendor_Active    Script Date: 11/17/00 11:54:34 AM ******/

/****** Object:  Stored Procedure dbo.RQVendor_Active    Script Date: 10/25/00 8:32:20 AM ******/

/****** Object:  Stored Procedure dbo.RQVendor_Active    Script Date: 10/10/00 4:15:43 PM ******/

/****** Object:  Stored Procedure dbo.RQVendor_Active    Script Date: 10/2/00 4:58:19 PM ******/

/****** Object:  Stored Procedure dbo.RQVendor_Active    Script Date: 9/1/00 9:39:25 AM ******/

/****** Object:  Stored Procedure dbo.RQVendor_Active    Script Date: 03/31/2000 12:21:24 PM ******/

/****** Object:  Stored Procedure dbo.RQVendor_Active    Script Date: 2/2/00 12:18:21 PM ******/

/****** Object:  Stored Procedure dbo.RQVendor_Active    Script Date: 12/17/97 10:49:14 AM ******/
CREATE Procedure RQVendor_Active @Parm1 Varchar(15) as
Select * From Vendor Where Status <> 'H' and
VendId Like @parm1
Order By VendId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQVendor_Active] TO [MSDSL]
    AS [dbo];

