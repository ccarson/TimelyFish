--*************************************************************
--	Purpose:Subtotals and Totals movements into a specific group
--		grouped by the TranDate and Source
--	Author: Charity Anderson
--	Date: 8/25/2005
--	Usage: Pig Group Verification Screen TranDetail DBNav 
--	Parms:PigGroupID
--*************************************************************

CREATE PROC dbo.pXP236PGTranDetail_IN
	(@parm1 as varchar(10))
AS
Select pg.PigGroupID, 
       tr.acct,
       tr.TranDate,
	   SourceID=cast(isnull(pg2.PigGroupID, pj.project) as varchar(10)),
       Source=cast(isnull(pg2.description,pj.project_desc) as varchar(30)),       
       Qty=(tr.Qty*tr.InvEffect),
       tr.TotalWgt,
	   GrandTotalWgt=
			Case when rtrim(Module)+rtrim(BatNbr)+rtrim(LineNbr)=
			(Select Top 1 rtrim(Module)+rtrim(BatNbr)+rtrim(LineNbr) from cftPGInvTran
									where PigGroupID=pg.PigGroupID
										and TranDate=tr.TranDate
										and SourcePigGroupID=tr.SourcePigGroupID
										and SourceProject=tr.SourceProject
										and Reversal=0
										order by SourceRefNbr DESC,SourceLineNbr DESC)
			then (Select sum(TotalWgt) from cftPGInvTran
					where Reversal=0
						  and rtrim(PigGroupID)=rtrim(pg.PigGroupID)
						  and TranDate=tr.TranDate
						  and rtrim(SourcePigGroupID)=rtrim(tr.SourcePigGroupID)
						  and rtrim(SourceProject)=rtrim(tr.SourceProject)
						  and rtrim(SourceRefNbr)<=rtrim(tr.SourceRefNbr))
						  else ' ' end,
		TotalQty=Case when rtrim(Module)+rtrim(BatNbr)+rtrim(LineNbr)=
			(Select Top 1 rtrim(Module)+rtrim(BatNbr)+rtrim(LineNbr) from cftPGInvTran
										where PigGroupID=pg.PigGroupID
										and TranDate=tr.TranDate
										and SourcePigGroupID=tr.SourcePigGroupID
										and SourceProject=tr.SourceProject
										and Reversal=0
										order by SourceRefNbr DESC,SourceLineNbr DESC)
			then (Select sum(Qty) from cftPGInvTran
					where Reversal=0
						  and rtrim(PigGroupID)=rtrim(pg.PigGroupID)
						  and TranDate=tr.TranDate
						  and rtrim(SourcePigGroupID)=rtrim(tr.SourcePigGroupID)
						  and rtrim(SourceProject)=rtrim(tr.SourceProject)
						  and rtrim(SourceRefNbr)<=rtrim(tr.SourceRefNbr))
						  else ' ' end,
		AvgWgt=Case when rtrim(Module)+rtrim(BatNbr)+rtrim(LineNbr)=
			(Select Top 1 rtrim(Module)+rtrim(BatNbr)+rtrim(LineNbr) from cftPGInvTran
										where PigGroupID=pg.PigGroupID
										and TranDate=tr.TranDate
										and SourcePigGroupID=tr.SourcePigGroupID
										and SourceProject=tr.SourceProject
										and Reversal=0
										order by SourceRefNbr DESC,SourceLineNbr DESC)
			then (Select sum(totalWgt)/sum(Qty) from cftPGInvTran
					where Reversal=0
						  and rtrim(PigGroupID)=rtrim(pg.PigGroupID)
						  and TranDate=tr.TranDate
						  and rtrim(SourcePigGroupID)=rtrim(tr.SourcePigGroupID)
						  and rtrim(SourceProject)=rtrim(tr.SourceProject)
						  and rtrim(SourceRefNbr)<=rtrim(tr.SourceRefNbr))
						  else ' ' end
	
  From cftPigGroup pg
  JOIN cftPGInvTran tr ON pg.PigGroupID=tr.PigGroupID
  LEFT JOIN pjproj pj ON tr.SourceProject=pj.project
  LEFT JOIN cftPigGroup pg2 ON tr.SourcePigGroupID=pg2.PigGroupID
  Where tr.Reversal<>'1' AND tr.TranTypeID IN ('MI','TI','PP') and pg.PigGroupID=@parm1
 order by TranDate,SourceID,SourceRefNbr ASC,SourceLineNbr ASC

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP236PGTranDetail_IN] TO [MSDSL]
    AS [dbo];

