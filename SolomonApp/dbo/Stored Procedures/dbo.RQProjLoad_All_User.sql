 /****** Object:  Stored Procedure dbo.RQProjLoad_All_User    Script Date: 9/4/2003 6:21:38 PM ******/

/****** Object:  Stored Procedure dbo.RQProjLoad_All_User    Script Date: 7/5/2002 2:44:43 PM ******/

/****** Object:  Stored Procedure dbo.RQProjLoad_All_User    Script Date: 1/7/2002 12:23:14 PM ******/

/****** Object:  Stored Procedure dbo.RQProjLoad_All_User    Script Date: 1/2/01 9:39:39 AM ******/

/****** Object:  Stored Procedure dbo.RQProjLoad_All_User    Script Date: 11/17/00 11:54:32 AM ******/

/****** Object:  Stored Procedure dbo.RQProjLoad_All_User    Script Date: 10/25/00 8:32:18 AM ******/

/****** Object:  Stored Procedure dbo.RQProjLoad_All_User    Script Date: 10/10/00 4:15:41 PM ******/

/****** Object:  Stored Procedure dbo.RQProjLoad_All_User    Script Date: 10/2/00 4:58:17 PM ******/

/****** Object:  Stored Procedure dbo.RQProjLoad_All_User    Script Date: 9/1/00 9:39:23 AM ******/

create procedure RQProjLoad_All_User
@parm1 varchar(2), @parm2 varchar(47)
as
Select * from RQProjAuth where
Doctype  = @parm1 and
UserId = @parm2
ORDER BY Project, DocType, RequestType, Budgeted, Authority, UserID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQProjLoad_All_User] TO [MSDSL]
    AS [dbo];

