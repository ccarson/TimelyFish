 /****** Object:  Stored Procedure dbo.InvtOrdHist_DBNAV    Script Date: 12/17/97 10:48:58 AM ******/
CREATE PROCEDURE InvtOrdHist_DBNAV @Parm1 Varchar(30) AS
	SELECT * FROM POReqDet, POReqHdr WHERE
	POReqDet.InvtID = @Parm1 AND
	POReqDet.ReqNbr = POReqHdr.ReqNbr AND
	POReqDet.ReqCntr = POReqHdr.ReqCntr
	ORDER BY POReqHdr.CreateDate DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[InvtOrdHist_DBNAV] TO [MSDSL]
    AS [dbo];

