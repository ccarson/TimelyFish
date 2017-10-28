 /****** Object:  Stored Procedure dbo.RQAuthHist_DBnav    Script Date: 9/4/2003 6:21:18 PM ******/

/****** Object:  Stored Procedure dbo.RQAuthHist_DBnav    Script Date: 7/5/2002 2:44:37 PM ******/

/****** Object:  Stored Procedure dbo.RQAuthHist_DBnav    Script Date: 1/7/2002 12:23:08 PM ******/

/****** Object:  Stored Procedure dbo.RQAuthHist_DBnav    Script Date: 1/2/01 9:39:33 AM ******/

/****** Object:  Stored Procedure dbo.RQAuthHist_DBnav    Script Date: 11/17/00 11:54:27 AM ******/

/****** Object:  Stored Procedure dbo.RQAuthHist_DBnav    Script Date: 10/25/00 8:32:13 AM ******/

/****** Object:  Stored Procedure dbo.RQAuthHist_DBnav    Script Date: 10/10/00 4:15:35 PM ******/

/****** Object:  Stored Procedure dbo.RQAuthHist_DBnav    Script Date: 10/2/00 4:58:10 PM ******/

/****** Object:  Stored Procedure dbo.RQAuthHist_DBnav    Script Date: 9/1/00 9:39:17 AM ******/
/****** Object:  Stored Procedure dbo.RQDeptAuth_DBnav    Script Date: 12/17/97 10:48:28 AM ******/
CREATE Procedure RQAuthHist_DBnav
@Parm1 Varchar(16),  @Parm2 Varchar(2), @Parm3 Varchar(2),
@Parm4 Varchar(2), @Parm5 Varchar(47), @Parm6 Varchar(1),  @parm7 varchar(1) as
Select * from RQAuthHist   where
Auth_Type = @parm7 and
Auth_ID  = @parm1 and
docType Like @Parm3 and
RequestType Like @Parm4 and
Budgeted like @Parm6 and
Authority Like @Parm2 and
UserId Like @Parm5
order by Auth_Type, Auth_id, DocType, RequestType, Budgeted, Authority, UserID, EffBegDate desc, EffEndDate


