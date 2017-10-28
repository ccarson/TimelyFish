 /****** Object:  Stored Procedure dbo.RQReqHdr_ReqNbr_Cntr    Script Date: 9/4/2003 6:21:39 PM ******/

/****** Object:  Stored Procedure dbo.RQReqHdr_ReqNbr_Cntr    Script Date: 7/5/2002 2:44:45 PM ******/

/****** Object:  Stored Procedure dbo.RQReqHdr_ReqNbr_Cntr    Script Date: 1/7/2002 12:23:15 PM ******/

/****** Object:  Stored Procedure dbo.RQReqHdr_ReqNbr_Cntr    Script Date: 1/2/01 9:39:40 AM ******/

/****** Object:  Stored Procedure dbo.RQReqHdr_ReqNbr_Cntr    Script Date: 11/17/00 11:54:33 AM ******/

/****** Object:  Stored Procedure dbo.RQReqHdr_ReqNbr_Cntr    Script Date: 10/25/00 8:32:19 AM ******/

/****** Object:  Stored Procedure dbo.RQReqHdr_ReqNbr_Cntr    Script Date: 10/10/00 4:15:42 PM ******/

/****** Object:  Stored Procedure dbo.RQReqHdr_ReqNbr_Cntr    Script Date: 10/2/00 4:58:17 PM ******/

/****** Object:  Stored Procedure dbo.RQReqHdr_ReqNbr_Cntr    Script Date: 9/1/00 9:39:24 AM ******/

/****** Object:  Stored Procedure dbo.RQReqHdr_ReqNbr_Cntr    Script Date: 03/31/2000 12:21:23 PM ******/

/****** Object:  Stored Procedure dbo.RQReqHdr_ReqNbr_Cntr    Script Date: 2/2/00 12:18:20 PM ******/

/****** Object:  Stored Procedure dbo.RQReqHdr_ReqNbr_Cntr    Script Date: 12/17/97 10:49:08 AM ******/
Create Procedure RQReqHdr_ReqNbr_Cntr @Parm1 Varchar(10), @Parm2 Varchar(2) as
SELECT * From RQReqHdr WHERE ReqNbr = @Parm1 and ReqCntr LIKE @Parm2
ORDER BY ReqNbr DESC, ReqCntr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQReqHdr_ReqNbr_Cntr] TO [MSDSL]
    AS [dbo];

