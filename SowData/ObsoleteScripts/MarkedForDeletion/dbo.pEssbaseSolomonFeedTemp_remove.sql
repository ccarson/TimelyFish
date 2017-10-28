CREATE  PROC [dbo].[pEssbaseSolomonFeedTemp_remove]
	AS
	-- Clear the week definition temp table and the day definition temp table
	TRUNCATE TABLE cftFeedOrderTemp

Begin Transaction
--Insert all date from cftFeedOrder Related to a Sow Farm
	
	INSERT INTO dbo.cftFeedOrderTemp (AvgWgt, BarnNbr, BatNbrAP, BatNbrGL, BatNbrIN, BinNbr,
CF01, CF02, CF03, CF04, CF05, CF06, CF07, CF08, CF09, CF10, CF11, CF12, CnvFactDel,
CnvFactOrd, Comment, CommentId, ContactId, ContAddrId, CpnyId, Crtd_DateTime, Crtd_Prog, 
Crtd_User, DateDel, DateOrd, DateReq, DateSched, DaysIn, FarmTentative, FeedPlanId, 
InvtIdDel, InvtIdDflt, InvtIdOrd, LoadNbr, Lupd_DateTime, Lupd_Prog, Lupd_User, 
MillAddrId, MillId, NoteId, OrdNbr, OrdType, PGQty, PigGroupId, Priority, Project, 
PrtByUser, PrtFlg, PrtRptFormat, QtyDel, QtyOrd, RelOrdNbr, Reversal, RoomNbr, 
SrcOrdNbr, StageDflt, StageOrd, Status, TaskId, UOMDel, UOMOrd, User1, User2, User3, User4,
User5, User6, User7, User8, UsingGroupActFlag, WithdrawalDays, WithdrawalFlg)

SELECT fo.AvgWgt, fo.BarnNbr, fo.BatNbrAP, fo.BatNbrGL, 
fo.BatNbrIN, fo.BinNbr, fo.CF01, fo.CF02, fo.CF03, fo.CF04, fo.CF05, 
fo.CF06, fo.CF07, fo.CF08, fo.CF09, fo.CF10, fo.CF11, fo.CF12, 
fo.CnvFactDel, fo.CnvFactOrd, fo.Comment, fo.CommentId, fo.ContactId, 
fo.ContAddrId, fo.CpnyId, fo.Crtd_DateTime, fo.Crtd_Prog, fo.Crtd_User, 
fo.DateDel, fo.DateOrd, fo.DateReq, fo.DateSched, fo.DaysIn, fo.FarmTentative, 
fo.FeedPlanId, fo.InvtIdDel, fo.InvtIdDflt, fo.InvtIdOrd, fo.LoadNbr, 
fo.Lupd_DateTime, fo.Lupd_Prog, fo.Lupd_User, fo.MillAddrId, fo.MillId, 
fo.NoteId, fo.OrdNbr, fo.OrdType, fo.PGQty, fo.PigGroupId, fo.Priority, 
fo.Project, fo.PrtByUser, fo.PrtFlg, fo.PrtRptFormat, fo.QtyDel, fo.QtyOrd, 
fo.RelOrdNbr, fo.Reversal, fo.RoomNbr, fo.SrcOrdNbr, fo.StageDflt, fo.StageOrd, 
fo.Status, fo.TaskId, fo.UOMDel, fo.UOMOrd, fo.User1, fo.User2, fo.User3, fo.User4, 
fo.User5, fo.User6, fo.User7, fo.User8, fo.UsingGroupActFlag, fo.WithdrawalDays, fo.WithdrawalFlg
FROM [$(SolomonApp)].dbo.cftFeedOrder fo				-- removed the earth reference 20130905 part of the saturn retirement.
--JOIN dbo.DayDefinition AS dd WITH (NOLOCK) ON fo.DateDel = dd.DayDate -- 20130905 changed to the solomonapp version
JOIN [$(SolomonApp)].dbo.cftDayDefinition AS dd WITH (NOLOCK) ON fo.DateDel = dd.DayDate
--JOIN vSowFarmBin v ON fo.ContactID = v.ContactID AND fo.BinNbr=v.BinNbr
JOIN WeekDefinitionTemp wd ON dd.WeekOfDate = wd.WeekOfDate




Commit

--Drop and Recreate Index
Drop INDEX cftFeedOrderTemp.cftFeedOrderTempEss

CREATE CLUSTERED INDEX cftFeedOrderTempEss
ON cftFeedOrderTemp (ContactID,DateDel)

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pEssbaseSolomonFeedTemp_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pEssbaseSolomonFeedTemp_remove] TO [se\analysts]
    AS [dbo];

