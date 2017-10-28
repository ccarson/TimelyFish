 /****** Object:  Stored Procedure dbo.RQApprHist_DBnav    Script Date: 9/4/2003 6:21:18 PM ******/

/****** Object:  Stored Procedure dbo.RQApprHist_DBnav    Script Date: 7/5/2002 2:44:37 PM ******/

/****** Object:  Stored Procedure dbo.RQApprHist_DBnav    Script Date: 1/7/2002 12:23:07 PM ******/

/****** Object:  Stored Procedure dbo.RQApprHist_DBnav    Script Date: 1/2/01 9:39:32 AM ******/

/****** Object:  Stored Procedure dbo.RQApprHist_DBnav    Script Date: 11/17/00 11:54:27 AM ******/

/****** Object:  Stored Procedure dbo.RQApprHist_DBnav    Script Date: 10/25/00 8:32:12 AM ******/

/****** Object:  Stored Procedure dbo.RQApprHist_DBnav    Script Date: 10/10/00 4:15:35 PM ******/

/****** Object:  Stored Procedure dbo.RQApprHist_DBnav    Script Date: 10/2/00 4:58:10 PM ******/

/****** Object:  Stored Procedure dbo.RQApprHist_DBnav    Script Date: 9/1/00 9:39:17 AM ******/
/****** Object:  Stored Procedure dbo.RQDept_DBnav    Script Date: 12/17/97 10:48:30 AM ******/
CREATE Procedure RQApprHist_DBnav
@Parm1 Varchar(16), @Parm2 Varchar(2), @Parm3 Varchar(2),
@Parm4 Varchar(2), @Parm5 Varchar(1), @parm6 varchar(1)
 as
Select * from RQApprHist  where
Auth_Type = @parm6 and
 Auth_ID  = @parm1 and
 DocType Like @Parm3 and
 RequestType Like @Parm4 and
 Budgeted LIKE @Parm5 and
 Authority Like @Parm2
 Order by Auth_Type, Auth_Id, Doctype, RequestType, Budgeted, Authority, EffBegDate desc, EffEndDate


