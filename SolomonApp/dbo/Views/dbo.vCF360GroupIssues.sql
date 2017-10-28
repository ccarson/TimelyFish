--*************************************************************
--	Purpose:Feed Orders for old Groups
--	Author: Charity Anderson
--	Date: 1/12/2005
--	Usage: Feed Order Exception		 
--	Parms: 
--*************************************************************

Create view vCF360GroupIssues 
as 
Select f.AvgWgt ,f.BarnNbr ,f.BatNbrAP  ,f.BatNbrGL ,f.BatNbrIN ,f.BinNbr ,
f.CnvFactDel ,f.CnvFactOrd,f.Comment ,f.CommentId ,f.ContactID,c.ContactName,
f.ContAddrId ,f.CpnyID ,f.Crtd_DateTime,f.Crtd_Prog ,f.Crtd_User,f.DateDel,f.DateOrd,
f.DateReq ,f.DateSched ,f.DaysIn,f.FeedPlanID,f.InvtIDDel,f.InvtIdDflt,f.InvtIdOrd ,
cast('Group Issue' as varchar(15)) as IssueType,f.LoadNbr,f.Lupd_DateTime,f.Lupd_Prog ,f.Lupd_User,f.MillAddrId,
f.MillId,f.NoteID ,f.OrdNbr,f.OrdType ,f.PGQty ,f.PigGroupID,f.Priority,f.project,
f.PrtFlg,f.QtyDel,f.QtyOrd,f.Reversal,f.RoomNbr,f.StageDflt,f.StageOrd  ,f.Status ,
f.TaskID,f.UOMDel,f.UOMOrd
from cftFeedOrder f
JOIN cftPigGroup pg on f.PigGroupID=pg.PigGroupID
JOIN vCF360NextGroupStart g on f.PigGroupID=g.PigGroupID
LEFT JOIN cftContact c on f.ContactID=c.ContactID
where g.NextStart is not null and f.DateSched>g.NextStart
and f.Status<>'X' and f.User8=0 and f.Status<>'C'
and left(f.OrdType,1)<>'R' and f.DateSched>'10/25/2004'




 