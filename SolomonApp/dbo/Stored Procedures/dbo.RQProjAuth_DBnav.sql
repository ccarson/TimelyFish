 /****** Object:  Stored Procedure dbo.RQProjAuth_DBnav    Script Date: 9/4/2003 6:21:38 PM ******/

/****** Object:  Stored Procedure dbo.RQProjAuth_DBnav    Script Date: 7/5/2002 2:44:43 PM ******/

/****** Object:  Stored Procedure dbo.RQProjAuth_DBnav    Script Date: 1/7/2002 12:23:13 PM ******/

/****** Object:  Stored Procedure dbo.RQProjAuth_DBnav    Script Date: 1/2/01 9:39:38 AM ******/

/****** Object:  Stored Procedure dbo.RQProjAuth_DBnav    Script Date: 11/17/00 11:54:32 AM ******/

/****** Object:  Stored Procedure dbo.RQProjAuth_DBnav    Script Date: 10/25/00 8:32:18 AM ******/

/****** Object:  Stored Procedure dbo.RQProjAuth_DBnav    Script Date: 10/10/00 4:15:41 PM ******/

/****** Object:  Stored Procedure dbo.RQProjAuth_DBnav    Script Date: 10/2/00 4:58:17 PM ******/

/****** Object:  Stored Procedure dbo.RQProjAuth_DBnav    Script Date: 9/1/00 9:39:23 AM ******/

/****** Object:  Stored Procedure dbo.RQProjAuth_DBnav    Script Date: 03/31/2000 12:21:22 PM ******/

/****** Object:  Stored Procedure dbo.RQProjAuth_DBnav    Script Date: 2/2/00 12:18:20 PM ******/

/****** Object:  Stored Procedure dbo.RQProjAuth_DBnav    Script Date: 12/17/97 10:49:07 AM ******/
CREATE Procedure RQProjAuth_DBnav @Parm1 Varchar(16),
@Parm2 Varchar(2), @Parm3 Varchar(47), @Parm4 Varchar(2), @Parm5 Varchar(2), @Parm6 Varchar(1) as
Select * from RQProjAuth  where Project = @parm1 and
docType = @Parm4 and
RequestType Like @Parm5 and
Budgeted Like @Parm6 and
Authority Like @Parm2 and
UserId Like @Parm3
Order by Project, DocType, RequestType, Budgeted, Authority, UserId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQProjAuth_DBnav] TO [MSDSL]
    AS [dbo];

