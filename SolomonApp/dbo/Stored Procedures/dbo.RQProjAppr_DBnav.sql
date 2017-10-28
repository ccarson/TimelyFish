 /****** Object:  Stored Procedure dbo.RQProjAppr_DBnav    Script Date: 9/4/2003 6:21:38 PM ******/

/****** Object:  Stored Procedure dbo.RQProjAppr_DBnav    Script Date: 7/5/2002 2:44:43 PM ******/

/****** Object:  Stored Procedure dbo.RQProjAppr_DBnav    Script Date: 1/7/2002 12:23:13 PM ******/

/****** Object:  Stored Procedure dbo.RQProjAppr_DBnav    Script Date: 1/2/01 9:39:38 AM ******/

/****** Object:  Stored Procedure dbo.RQProjAppr_DBnav    Script Date: 11/17/00 11:54:32 AM ******/

/****** Object:  Stored Procedure dbo.RQProjAppr_DBnav    Script Date: 10/25/00 8:32:18 AM ******/

/****** Object:  Stored Procedure dbo.RQProjAppr_DBnav    Script Date: 10/10/00 4:15:41 PM ******/

/****** Object:  Stored Procedure dbo.RQProjAppr_DBnav    Script Date: 10/2/00 4:58:17 PM ******/

/****** Object:  Stored Procedure dbo.RQProjAppr_DBnav    Script Date: 9/1/00 9:39:23 AM ******/

/****** Object:  Stored Procedure dbo.RQProjAppr_DBnav    Script Date: 03/31/2000 12:21:22 PM ******/

/****** Object:  Stored Procedure dbo.RQProjAppr_DBnav    Script Date: 2/2/00 12:18:20 PM ******/

/****** Object:  Stored Procedure dbo.RQProjAppr_DBnav    Script Date: 12/17/97 10:48:42 AM ******/
CREATE Procedure RQProjAppr_DBnav @Parm1 Varchar(16),
@Parm2 Varchar(2), @Parm3 Varchar(2), @Parm4 Varchar(2), @Parm5 Varchar(1) as
Select * from RQProjAppr where
Project = @Parm1 and
Doctype = @Parm3 and
Requesttype LIKE @Parm4 and
Budgeted LIKE @Parm5 and
Authority LIKE @Parm2
Order by Project, Doctype, RequestType, Budgeted, Authority



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQProjAppr_DBnav] TO [MSDSL]
    AS [dbo];

