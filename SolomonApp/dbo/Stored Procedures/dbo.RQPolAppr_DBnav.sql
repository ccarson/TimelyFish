 /****** Object:  Stored Procedure dbo.RQPolAppr_DBnav    Script Date: 9/4/2003 6:21:38 PM ******/

/****** Object:  Stored Procedure dbo.RQPolAppr_DBnav    Script Date: 7/5/2002 2:44:42 PM ******/

/****** Object:  Stored Procedure dbo.RQPolAppr_DBnav    Script Date: 1/7/2002 12:23:13 PM ******/

/****** Object:  Stored Procedure dbo.RQPolAppr_DBnav    Script Date: 1/2/01 9:39:38 AM ******/

/****** Object:  Stored Procedure dbo.RQPolAppr_DBnav    Script Date: 11/17/00 11:54:32 AM ******/

/****** Object:  Stored Procedure dbo.RQPolAppr_DBnav    Script Date: 10/25/00 8:32:18 AM ******/

/****** Object:  Stored Procedure dbo.RQPolAppr_DBnav    Script Date: 10/10/00 4:15:40 PM ******/

/****** Object:  Stored Procedure dbo.RQPolAppr_DBnav    Script Date: 10/2/00 4:58:16 PM ******/

/****** Object:  Stored Procedure dbo.RQPolAppr_DBnav    Script Date: 9/1/00 9:39:22 AM ******/

/****** Object:  Stored Procedure dbo.RQPolAppr_DBnav    Script Date: 03/31/2000 12:21:22 PM ******/

/****** Object:  Stored Procedure dbo.RQPolAppr_DBnav    Script Date: 2/2/00 12:18:19 PM ******/

/****** Object:  Stored Procedure dbo.RQPolAppr_DBnav    Script Date: 12/17/97 10:48:38 AM ******/
CREATE Procedure RQPolAppr_DBnav @Parm1 Varchar(10), @parm2 Varchar(2),
@parm3 Varchar(2), @parm4 Varchar(2), @parm5 Varchar(10) as
Select * from RQPolicyAppr  where
PolicyID  = @Parm1 and
DocType = @parm3 and
RequestType LIKE @parm4 and
MaterialType LIKE @parm5 and
Authority LIKE @parm2

Order by PolicyID,  DocType, RequestType, MaterialType, Authority



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQPolAppr_DBnav] TO [MSDSL]
    AS [dbo];

