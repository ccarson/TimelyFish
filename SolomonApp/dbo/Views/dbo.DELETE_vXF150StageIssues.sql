
--*************************************************************
--	Purpose:Feed Orders with Stage Issues
--	Author: Charity Anderson
--	Date: 1/3/2004
--	Usage: Feed Order Exception		 
--	Parms: 
--*************************************************************
/********************* REVISIONS **********************
Date       User        Ref     	Description
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
12/15/06   mdawson     Bug94   	MARKED FOR DELETION: when Visual Source Safe is implemented
				objects can be removed if they are prefixed with 'DELETE_'
 
****************** END REVISIONS *********************/

Create view dbo.DELETE_vXF150StageIssues as 
Select f.AvgWgt ,f.BarnNbr ,f.BatNbrAP  ,f.BatNbrGL ,f.BatNbrIN ,f.BinNbr ,
f.CnvFactDel ,f.CnvFactOrd,f.Comment ,f.CommentId ,f.ContactID,c.ContactName,
f.ContAddrId ,f.CpnyID ,f.Crtd_DateTime,f.Crtd_Prog ,f.Crtd_User,f.DateDel,f.DateOrd,
f.DateReq ,f.DateSched ,f.DaysIn,f.FeedPlanID,f.InvtIDDel,f.InvtIdDflt,f.InvtIdOrd ,
cast('Stage' as varchar(15)) as IssueType,f.LoadNbr,f.Lupd_DateTime,f.Lupd_Prog ,f.Lupd_User,f.MillAddrId,
f.MillId,f.NoteID ,f.OrdNbr,f.OrdType ,f.PGQty ,f.PigGroupID,f.Priority,f.project,
f.PrtFlg,f.QtyDel,f.QtyOrd,f.Reversal,f.RoomNbr,f.StageDflt,f.StageOrd  ,f.Status ,
f.TaskID,f.UOMDel,f.UOMOrd

From cftFeedOrder f
LEFT JOIN (Select PigGroupID, Max(StageOrd) as Stage 
		from cftFeedOrder group by PigGroupID) maxStage
JOIN (Select PigGroupID,StageOrd, Max(DateReq) as LastDate
		from cftFeedOrder group by PigGroupID, StageOrd) maxDate
		on maxStage.PiggroupID=maxDate.PigGroupID and maxStage.Stage=maxDate.StageOrd
	on f.PigGroupID=maxStage.PigGroupID
Join cftContact c on f.ContactID=c.ContactID
where f.StageOrd<maxStage.stage and f.DateReq>maxDate.LastDate and f.PigGroupID>''
 and f.User8=0 and f.Status<>'C' and f.Status<>'X'


 
