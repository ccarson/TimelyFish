--*************************************************************
--	Purpose: Current Pig Group Transactions
--	Author: Sue Matter
--	Date: 12/1/2004
--	Usage: XP601 Pig Group Maintenance
--	Parms: @parm1 (Pig Group ID)
--	       
--*************************************************************



CREATE    View [dbo].[cfv_XP601Tran]
AS
Select pg.ProjectID,
       pg.TaskID,
       pg.description,
       tr.acct,
       tr.TranDate,
       tr.BatNbr,
       tr.SourceBatNbr,
       tr.SourceLineNbr,
       pj.project_desc As SourceSite,
       SourceID=ISNULL(pg2.PigGroupID,pj.project),        
       SourceDesc=ISNULL(pg2.Description,pj.project_desc),
       Qty=(tr.Qty*tr.InvEffect),
       tr.TotalWgt,
       DestID=Case when tr.TranTypeID='TO' then ISNULL(pg3.PigGroupID,pj2.project) else pg4.PigGroupID end,        
       DestDesc=Case when tr.TranTypeID='TO' then ISNULL(pg3.Description,pj2.project_desc) else pg4.Description end
	,PM.pmid
  From cftPigGroup pg
  JOIN cftPGInvTran tr ON pg.PigGroupID=tr.PigGroupID
  LEFT JOIN pjproj pj ON tr.SourceProject=pj.project
  LEFT JOIN cftPigGroup pg2 ON tr.SourcePigGroupID=pg2.PigGroupID
  LEFT JOIN cftPMTranspRecord PM ON tr.SourceBatNbr=PM.BatchNbr AND tr.SourceRefNbr=PM.RefNbr
  LEFT JOIN cftPgInvXfer xf ON tr.SourceBatNbr=xf.BatNbr AND tr.SourceLineNbr=xf.LineNbr
  LEFT JOIN cftPigGroup pg3 ON PM.DestTask=pg3.TaskID
  LEFT JOIN cftPigGroup pg4 ON xf.DestPigGroupID=pg4.PigGroupID
  LEFT JOIN pjproj pj2 ON PM.DestProject=pj2.project
  Where tr.Reversal<>'1' AND tr.TranTypeID IN ('MI','TI','MO','TO','PP')


 