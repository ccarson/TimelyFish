 /****** Object:  Stored Procedure dbo.RQDet_RQHdr_DBNAV    Script Date: 9/4/2003 6:21:19 PM ******/

/****** Object:  Stored Procedure dbo.RQDet_RQHdr_DBNAV    Script Date: 7/5/2002 2:44:39 PM ******/

/****** Object:  Stored Procedure dbo.RQDet_RQHdr_DBNAV    Script Date: 1/7/2002 12:23:10 PM ******/

/****** Object:  Stored Procedure dbo.RQDet_RQHdr_DBNAV    Script Date: 1/2/01 9:39:35 AM ******/

/****** Object:  Stored Procedure dbo.RQDet_RQHdr_DBNAV    Script Date: 11/17/00 11:54:29 AM ******/

/****** Object:  Stored Procedure dbo.RQDet_RQHdr_DBNAV    Script Date: 10/25/00 8:32:15 AM ******/

/****** Object:  Stored Procedure dbo.RQDet_RQHdr_DBNAV    Script Date: 10/10/00 4:15:37 PM ******/

/****** Object:  Stored Procedure dbo.RQDet_RQHdr_DBNAV    Script Date: 10/2/00 4:58:12 PM ******/

/****** Object:  Stored Procedure dbo.RQDet_RQHdr_DBNAV    Script Date: 9/1/00 9:39:19 AM ******/

/****** Object:  Stored Procedure dbo.RQDet_RQHdr_DBNAV    Script Date: 03/31/2000 12:21:21 PM ******/

/****** Object:  Stored Procedure dbo.RQDet_RQHdr_DBNAV    Script Date: 2/2/00 12:18:18 PM ******/

/****** Object:  Stored Procedure dbo.RQDet_RQHdr_DBNAV Script Date: 12/17/97 10:49:15 AM ******/
CREATE PROCEDURE RQDet_RQHdr_DBNAV @Parm1 Varchar(24) AS
	SELECT RQReqHdr.ReqNbr, RQReqHdr.ReqCntr,
               RQReqDet.Unit, RQReqDet.Qty, rqreqdet.unitcost, RQReqDet.ExtCost,
               RQReqHdr.CreateDate, RQReqHdr.PODate,
               RQReqDet.Status
        FROM RQReqDet, RQReqHdr WHERE
	RQReqDet.InvtID = @Parm1 AND
	RQReqDet.ReqNbr = RQReqHdr.ReqNbr AND
	RQReqDet.ReqCntr = RQReqHdr.ReqCntr
	ORDER BY RQReqHdr.CreateDate DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQDet_RQHdr_DBNAV] TO [MSDSL]
    AS [dbo];

