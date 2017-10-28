 /****** Object:  Stored Procedure dbo.RQApprHist_Fetch    Script Date: 9/4/2003 6:21:18 PM ******/

/****** Object:  Stored Procedure dbo.RQApprHist_Fetch    Script Date: 7/5/2002 2:44:37 PM ******/

/****** Object:  Stored Procedure dbo.RQApprHist_Fetch    Script Date: 1/7/2002 12:23:08 PM ******/

/****** Object:  Stored Procedure dbo.RQApprHist_Fetch    Script Date: 1/2/01 9:39:32 AM ******/

/****** Object:  Stored Procedure dbo.RQApprHist_Fetch    Script Date: 11/17/00 11:54:27 AM ******/

/****** Object:  Stored Procedure dbo.RQApprHist_Fetch    Script Date: 10/25/00 8:32:13 AM ******/

/****** Object:  Stored Procedure dbo.RQApprHist_Fetch    Script Date: 10/10/00 4:15:35 PM ******/

/****** Object:  Stored Procedure dbo.RQApprHist_Fetch    Script Date: 10/2/00 4:58:10 PM ******/

/****** Object:  Stored Procedure dbo.RQApprHist_Fetch    Script Date: 9/1/00 9:39:17 AM ******/
CREATE PROCEDURE RQApprHist_Fetch
@parm1 varchar(1), @parm2 varchar(16),
@parm3 varchar(2), @parm4 varchar(2),
@parm5 varchar(1), @parm6 varchar(2)
 as

Select * from RQApprHist where
Auth_Type = @parm1 and
Auth_ID = @parm2 and
DocType = @parm3 and
RequestType = @parm4 and
Budgeted = @parm5 and
Authority = @parm6 and
EffEndDate = '01/01/1900'


