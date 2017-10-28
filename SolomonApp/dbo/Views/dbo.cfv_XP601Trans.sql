--*************************************************************
--	Purpose: Current Pig Group Transaction Details
--	Author: Sue Matter
--	Date: 4/21/2005
--	Usage: XP601
--	Parms: @parm1 (Pig Group ID)
--	       
--*************************************************************


CREATE  VIEW cfv_XP601Trans
AS
Select pg.ProjectID,
       pg.TaskID,
       pg.description,
       tr.acct,
       tr.TranDate,
       tr.BatNbr,
       tr.SourceBatNbr,
       tr.SourceLineNbr,
       Qty=(tr.Qty*tr.InvEffect),
       tr.TotalWgt,
       RefID= CASE when tr.acct IN ('PIG MOVE IN','PIG TRANSFER IN','PIG PURCHASE') then
			ISNULL(pg2.PigGroupID,pj.project)
			ELSE 
		        Case when tr.TranTypeID='TO' then ISNULL(pg3.PigGroupID,pj2.project) else pg4.PigGroupID end
			END,
       RefDesc= CASE when tr.acct IN ('PIG MOVE IN','PIG TRANSFER IN','PIG PURCHASE') then
			ISNULL(pg2.Description,pj.project_desc)
			ELSE 
		        Case when tr.TranTypeID='TO' then ISNULL(pg3.Description,pj2.project_desc) else pg4.Description end
			END
  From cftPigGroup pg
  JOIN cftPGInvTran tr ON pg.PigGroupID=tr.PigGroupID
  LEFT JOIN pjproj pj ON tr.SourceProject=pj.project
  LEFT JOIN cftPigGroup pg2 ON tr.SourcePigGroupID=pg2.PigGroupID
  LEFT JOIN cftPMTranspRecord PM ON tr.SourceBatNbr=PM.BatchNbr AND tr.SourceRefNbr=PM.RefNbr
  LEFT JOIN cftPgInvXfer xf ON tr.SourceBatNbr=xf.BatNbr AND tr.SourceLineNbr=xf.LineNbr
  LEFT JOIN cftPigGroup pg3 ON PM.DestTask=pg3.TaskID
  LEFT JOIN cftPigGroup pg4 ON xf.DestPigGroupID=pg4.PigGroupID
  LEFT JOIN pjproj pj2 ON PM.DestProject=pj2.project
  Where tr.Reversal<>'1' AND tr.acct IN ('PIG MOVE IN','PIG TRANSFER IN','PIG PURCHASE','PIG MOVE OUT','PIG TRANSFER OUT')

