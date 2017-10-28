 /****** Object:  Stored Procedure dbo.RQSubLoad    Script Date: 9/4/2003 6:21:40 PM ******/

/****** Object:  Stored Procedure dbo.RQSubLoad    Script Date: 7/5/2002 2:44:45 PM ******/

/****** Object:  Stored Procedure dbo.RQSubLoad    Script Date: 1/7/2002 12:23:15 PM ******/

/****** Object:  Stored Procedure dbo.RQSubLoad    Script Date: 1/2/01 9:39:40 AM ******/

/****** Object:  Stored Procedure dbo.RQSubLoad    Script Date: 11/17/00 11:54:34 AM ******/

/****** Object:  Stored Procedure dbo.RQSubLoad    Script Date: 10/25/00 8:32:20 AM ******/

/****** Object:  Stored Procedure dbo.RQSubLoad    Script Date: 10/10/00 4:15:42 PM ******/

/****** Object:  Stored Procedure dbo.RQSubLoad    Script Date: 10/2/00 4:58:18 PM ******/

/****** Object:  Stored Procedure dbo.RQSubLoad    Script Date: 9/1/00 9:39:25 AM ******/
CREATE PROCEDURE RQSubLoad @parm1 varchar(24), @parm2 varchar(24)  AS

select * from subacct where active <> 0
and sub >= @parm1
and sub <= @parm2
order by sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQSubLoad] TO [MSDSL]
    AS [dbo];

