 /****** Object:  Stored Procedure dbo.RQReqHist_UniqueID_Dpt_dbnav    Script Date: 9/4/2003 6:21:40 PM ******/

/****** Object:  Stored Procedure dbo.RQReqHist_UniqueID_Dpt_dbnav    Script Date: 7/5/2002 2:44:45 PM ******/

/****** Object:  Stored Procedure dbo.RQReqHist_UniqueID_Dpt_dbnav    Script Date: 1/7/2002 12:23:15 PM ******/

/****** Object:  Stored Procedure dbo.RQReqHist_UniqueID_Dpt_dbnav    Script Date: 1/2/01 9:39:40 AM ******/

/****** Object:  Stored Procedure dbo.RQReqHist_UniqueID_Dpt_dbnav    Script Date: 11/17/00 11:54:34 AM ******/

/****** Object:  Stored Procedure dbo.RQReqHist_UniqueID_Dpt_dbnav    Script Date: 10/25/00 8:32:19 AM ******/

/****** Object:  Stored Procedure dbo.RQReqHist_UniqueID_Dpt_dbnav    Script Date: 10/10/00 4:15:42 PM ******/

/****** Object:  Stored Procedure dbo.RQReqHist_UniqueID_Dpt_dbnav    Script Date: 10/2/00 4:58:18 PM ******/

/****** Object:  Stored Procedure dbo.RQReqHist_UniqueID_Dpt_dbnav    Script Date: 9/1/00 9:39:24 AM ******/

/****** Object:  Stored Procedure dbo.RQReqHist_UniqueID_Dpt_dbnav    Script Date: 03/31/2000 12:21:23 PM ******/

/****** Object:  Stored Procedure dbo.RQReqHist_UniqueID_Dpt_dbnav    Script Date: 2/2/00 12:18:21 PM ******/

/****** Object:  Stored Procedure dbo.RQReqHist_UniqueID_Dpt_dbnav    Script Date: 12/17/97 10:48:50 AM ******/
CREATE PROCEDURE RQReqHist_UniqueID_Dpt_dbnav @parm1 Varchar(10), @parm2 Varchar(17), @Parm3 Varchar(47)  AS
SELECT * FROM RQReqHist
WHERE ReqNbr = @parm1 and
(UniqueID Like @parm2 or UniqueID = '0000')  and
UserID LIKE @Parm3 and
ApprPath IN ('D', 'J')
ORDER BY ReqNbr, UniqueID, TranDate DESC, TranTime DESC, UserID, ApprPath



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQReqHist_UniqueID_Dpt_dbnav] TO [MSDSL]
    AS [dbo];

