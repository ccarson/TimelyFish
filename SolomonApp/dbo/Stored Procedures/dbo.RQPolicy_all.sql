 /****** Object:  Stored Procedure dbo.RQPolicy_all    Script Date: 9/4/2003 6:21:38 PM ******/

/****** Object:  Stored Procedure dbo.RQPolicy_all    Script Date: 7/5/2002 2:44:42 PM ******/

/****** Object:  Stored Procedure dbo.RQPolicy_all    Script Date: 1/7/2002 12:23:13 PM ******/

/****** Object:  Stored Procedure dbo.RQPolicy_all    Script Date: 1/2/01 9:39:38 AM ******/

/****** Object:  Stored Procedure dbo.RQPolicy_all    Script Date: 11/17/00 11:54:32 AM ******/

/****** Object:  Stored Procedure dbo.RQPolicy_all    Script Date: 10/25/00 8:32:18 AM ******/

/****** Object:  Stored Procedure dbo.RQPolicy_all    Script Date: 10/10/00 4:15:40 PM ******/

/****** Object:  Stored Procedure dbo.RQPolicy_all    Script Date: 10/2/00 4:58:16 PM ******/

/****** Object:  Stored Procedure dbo.RQPolicy_all    Script Date: 9/1/00 9:39:23 AM ******/

/****** Object:  Stored Procedure dbo.RQPolicy_all    Script Date: 03/31/2000 12:21:22 PM ******/

/****** Object:  Stored Procedure dbo.RQPolicy_all    Script Date: 2/2/00 12:18:20 PM ******/

/****** Object:  Stored Procedure dbo.RQPolicy_all    Script Date: 12/17/97 10:48:41 AM ******/
Create Procedure RQPolicy_all @Parm1 Varchar(10) as
Select * from RQPolicy Where PolicyID like @Parm1
Order by PolicyId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQPolicy_all] TO [MSDSL]
    AS [dbo];

