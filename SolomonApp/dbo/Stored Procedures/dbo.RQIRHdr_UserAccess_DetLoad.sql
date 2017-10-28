 /****** Object:  Stored Procedure dbo.RQIRHdr_UserAccess_DetLoad    Script Date: 9/4/2003 6:21:20 PM ******/

/****** Object:  Stored Procedure dbo.RQIRHdr_UserAccess_DetLoad    Script Date: 7/5/2002 2:44:40 PM ******/

/****** Object:  Stored Procedure dbo.RQIRHdr_UserAccess_DetLoad    Script Date: 1/7/2002 12:23:10 PM ******/

/****** Object:  Stored Procedure dbo.RQIRHdr_UserAccess_DetLoad    Script Date: 1/2/01 9:39:36 AM ******/

/****** Object:  Stored Procedure dbo.RQIRHdr_UserAccess_DetLoad    Script Date: 11/17/00 11:54:30 AM ******/

/****** Object:  Stored Procedure dbo.RQIRHdr_UserAccess_DetLoad    Script Date: 10/25/00 8:32:15 AM ******/

/****** Object:  Stored Procedure dbo.RQIRHdr_UserAccess_DetLoad    Script Date: 10/10/00 4:15:38 PM ******/

/****** Object:  Stored Procedure dbo.RQIRHdr_UserAccess_DetLoad    Script Date: 10/2/00 4:58:13 PM ******/

/****** Object:  Stored Procedure dbo.RQIRHdr_UserAccess_DetLoad    Script Date: 9/1/00 9:39:20 AM ******/
CREATE PROCEDURE RQIRHdr_UserAccess_DetLoad @parm1 varchar(11), @parm2 varchar(48), @parm3 varchar(10)  AS

select * from rqitemreqhdr where
RequstnrDept like @parm1 and
requstnr like @parm2 and
itemreqnbr like @parm3
order by descr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQIRHdr_UserAccess_DetLoad] TO [MSDSL]
    AS [dbo];

