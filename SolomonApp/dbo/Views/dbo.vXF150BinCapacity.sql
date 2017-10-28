--*************************************************************
--	Purpose:Feed Orders exceeding Bin Capacity 
--	Author: Charity Anderson
--	Date: 12/28/2004
--	Usage: Feed Order Exception		 
--	Parms: 
--*************************************************************
Create view vXF150BinCapacity as 
Select f.AvgWgt ,f.BarnNbr ,f.BatNbrAP  ,f.BatNbrGL ,f.BatNbrIN ,f.BinNbr ,
f.CnvFactDel ,f.CnvFactOrd,f.Comment ,f.CommentId ,f.ContactID,c.ContactName,
f.ContAddrId ,f.CpnyID ,f.Crtd_DateTime,f.Crtd_Prog ,f.Crtd_User,f.DateDel,f.DateOrd,
f.DateReq ,f.DateSched ,f.DaysIn,f.FeedPlanID,f.InvtIDDel,f.InvtIdDflt,f.InvtIdOrd ,
cast('Bin Capacity' as varchar(15)) as IssueType,f.LoadNbr,f.Lupd_DateTime,f.Lupd_Prog ,f.Lupd_User,f.MillAddrId,
f.MillId,f.NoteID ,f.OrdNbr,f.OrdType ,f.PGQty ,f.PigGroupID,f.Priority,f.project,
f.PrtFlg,f.QtyDel,f.QtyOrd,f.Reversal,f.RoomNbr,f.StageDflt,f.StageOrd  ,f.Status ,
f.TaskID,f.UOMDel,f.UOMOrd
From cftFeedOrder f
JOIN cftBin b on f.ContactID=b.ContactID and f.BinNbr=b.BinNBr
JOIN cftBinType bt on b.BinTypeID=bt.BinTypeID
JOIN cftContact c on f.ContactID=c.ContactID
WHERE f.QtyOrd>bt.BinCapacity 
and f.Status<>'X' and f.User8=0 and f.Status<>'C'

 