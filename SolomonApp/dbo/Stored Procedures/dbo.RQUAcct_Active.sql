 /****** Object:  Stored Procedure dbo.RQUAcct_Active    Script Date: 9/4/2003 6:21:40 PM ******/

/****** Object:  Stored Procedure dbo.RQUAcct_Active    Script Date: 7/5/2002 2:44:45 PM ******/

/****** Object:  Stored Procedure dbo.RQUAcct_Active    Script Date: 1/7/2002 12:23:15 PM ******/

/****** Object:  Stored Procedure dbo.RQUAcct_Active    Script Date: 1/2/01 9:39:41 AM ******/

/****** Object:  Stored Procedure dbo.RQUAcct_Active    Script Date: 11/17/00 11:54:34 AM ******/

/****** Object:  Stored Procedure dbo.RQUAcct_Active    Script Date: 10/25/00 8:32:20 AM ******/

/****** Object:  Stored Procedure dbo.RQUAcct_Active    Script Date: 10/10/00 4:15:42 PM ******/

/****** Object:  Stored Procedure dbo.RQUAcct_Active    Script Date: 10/2/00 4:58:18 PM ******/

/****** Object:  Stored Procedure dbo.RQUAcct_Active    Script Date: 9/1/00 9:39:25 AM ******/

/****** Object:  Stored Procedure dbo.RQUAcct_Active    Script Date: 03/31/2000 12:21:23 PM ******/

/****** Object:  Stored Procedure dbo.RQUAcct_Active    Script Date: 2/2/00 12:18:21 PM ******/

/****** Object:  Stored Procedure dbo.RQUAcct_Active    Script Date: 12/17/97 10:49:12 AM ******/
Create Procedure RQUAcct_Active @parm1 Varchar(47), @parm2 Varchar(10) as
Select * from RQUserAcct  where
UserId = @parm1 and
Acct LIKE @parm2
order by UserId,Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQUAcct_Active] TO [MSDSL]
    AS [dbo];

