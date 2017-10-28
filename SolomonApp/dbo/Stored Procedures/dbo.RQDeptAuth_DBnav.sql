 /****** Object:  Stored Procedure dbo.RQDeptAuth_DBnav    Script Date: 9/4/2003 6:21:19 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAuth_DBnav    Script Date: 7/5/2002 2:44:39 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAuth_DBnav    Script Date: 1/7/2002 12:23:10 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAuth_DBnav    Script Date: 1/2/01 9:39:35 AM ******/

/****** Object:  Stored Procedure dbo.RQDeptAuth_DBnav    Script Date: 11/17/00 11:54:29 AM ******/

/****** Object:  Stored Procedure dbo.RQDeptAuth_DBnav    Script Date: 10/25/00 8:32:14 AM ******/

/****** Object:  Stored Procedure dbo.RQDeptAuth_DBnav    Script Date: 10/10/00 4:15:37 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAuth_DBnav    Script Date: 10/2/00 4:58:12 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAuth_DBnav    Script Date: 9/1/00 9:39:19 AM ******/

/****** Object:  Stored Procedure dbo.RQDeptAuth_DBnav    Script Date: 03/31/2000 12:21:21 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAuth_DBnav    Script Date: 2/2/00 12:18:18 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAuth_DBnav    Script Date: 12/17/97 10:48:28 AM ******/
CREATE Procedure RQDeptAuth_DBnav @Parm1 Varchar(10),  @Parm2 Varchar(2), @Parm3 Varchar(2), @Parm4 Varchar(2), @Parm5 Varchar(47), @Parm6 Varchar(1) as
Select * from RQDeptAuth   where DeptID  = @parm1 and
docType Like @Parm3 and
RequestType Like @Parm4 and
Budgeted like @Parm6 and
Authority Like @Parm2 and
UserId Like @Parm5
order by Deptid, DocType, RequestType, Budgeted, Authority, UserID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQDeptAuth_DBnav] TO [MSDSL]
    AS [dbo];

