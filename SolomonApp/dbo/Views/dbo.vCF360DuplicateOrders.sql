--*************************************************************
--	Purpose:Duplicate Feed Orders 
--	Author: Charity Anderson
--	Date: 12/28/2004
--	Usage: Feed Order Exception		 
--	Parms: 
--*************************************************************

Create view vCF360DuplicateOrders as 
Select  f.AvgWgt ,f.BarnNbr ,f.BatNbrAP  ,f.BatNbrGL ,f.BatNbrIN ,f.BinNbr ,
f.CnvFactDel ,f.CnvFactOrd,f.Comment ,f.CommentId ,f.ContactID,c.ContactName,
f.ContAddrId ,f.CpnyID ,f.Crtd_DateTime,f.Crtd_Prog ,f.Crtd_User,f.DateDel,f.DateOrd,
f.DateReq ,f.DateSched ,f.DaysIn,f.FeedPlanID,f.InvtIDDel,f.InvtIdDflt,f.InvtIdOrd ,
cast('Duplicate' as varchar(15)) as IssueType,f.LoadNbr,f.Lupd_DateTime,f.Lupd_Prog ,f.Lupd_User,f.MillAddrId,
f.MillId,f.NoteID ,f.OrdNbr,f.OrdType ,f.PGQty ,f.PigGroupID,f.Priority,f.project,
f.PrtFlg,f.QtyDel,f.QtyOrd,f.Reversal,f.RoomNbr,f.StageDflt,f.StageOrd  ,f.Status ,
f.TaskID,f.UOMDel,f.UOMOrd

FROM dbo.cftFeedOrder f 
JOIN
	(SELECT     ContactId,BinNbr,QtyOrd,DateSched,COUNT(OrdNbr) AS Expr1
	FROM          dbo.cftFeedOrder
	GROUP BY ContactId,BinNbr,PigGroupId,InvtIdOrd,QtyOrd,DateSched,OrdType
	HAVING      (COUNT(OrdNbr) > 1) and left(OrdType,1)<>'R') dup 
ON f.ContactId = dup.ContactId 
AND f.BinNbr = dup.BinNbr 
AND f.DateSched = dup.DateSched 
AND f.QtyOrd = dup.QtyOrd
and f.Status<>'X' and f.Status<>'C'

LEFT JOIN cftContact c on f.ContactID=c.ContactID
where f.User8=0


 