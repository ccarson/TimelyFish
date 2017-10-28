

/**************************************************************
	Purpose:Feed Orders on Hold for Bin Verification
	Author: mdawson
	Date: 12/15/2006
	Usage: Feed Order Exception		 
	Parms: 
**************************************************************/

CREATE VIEW dbo.vXF150HoldVerification
AS
SELECT     f.AvgWgt, f.BarnNbr, f.BatNbrAP, f.BatNbrGL, f.BatNbrIN, f.BinNbr, f.CnvFactDel, f.CnvFactOrd, f.Comment, f.CommentId, f.ContactId, c.ContactName, 
                      f.ContAddrId, f.CpnyId, f.Crtd_DateTime, f.Crtd_Prog, f.Crtd_User, f.DateDel, f.DateOrd, f.DateReq, f.DateSched, f.DaysIn, f.FeedPlanId, f.InvtIdDel, 
                      f.InvtIdDflt, f.InvtIdOrd, CAST('Hold Verification' AS varchar(15)) AS IssueType, f.LoadNbr, f.Lupd_DateTime, f.Lupd_Prog, f.Lupd_User, f.MillAddrId, 
                      f.MillId, f.NoteId, f.OrdNbr, f.OrdType, f.PGQty, f.PigGroupId, f.Priority, f.Project, f.PrtFlg, f.QtyDel, f.QtyOrd, f.Reversal, f.RoomNbr, f.StageDflt, 
                      f.StageOrd, f.Status, f.TaskId, f.UOMDel, f.UOMOrd
FROM         dbo.cftFeedOrder f INNER JOIN
                      dbo.cftBin b ON f.ContactId = b.ContactID AND f.BinNbr = b.BinNbr INNER JOIN
                      dbo.cftBinType bt ON b.BinTypeID = bt.BinTypeID INNER JOIN
                      dbo.cftContact c ON f.ContactId = c.ContactID
WHERE     ISNUMERIC(LEFT(f.InvtIdDflt, 3)) = 1
AND	  (f.Status <> 'X') AND (f.User8 = 0) AND (f.Status <> 'C') AND (f.Status = 'B') AND (CAST(LEFT(f.InvtIdDflt, 3) AS INT) < 52)


