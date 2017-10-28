
--*************************************************************
--	Purpose:Converts PMTranspRecords to InvTran records
--	Author: Charity Anderson
--	Date: 9/8/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (BatchNbr)
--	      
--*************************************************************
CREATE PROC dbo.pXP135InvTranXfer
	@parm1 as varchar(6)

AS
SELECT DISTINCT 
                q.Qty, t1.acct, t1.AffectEntity, t1.InvEffect, t.BatchNbr, t.RefNbr,
				t.DestProject as Project , t.DestTask as Task,
		        t.AvgWgt, q.LineNbr, q.PigGradeCatTypeID, 
                d.PigGroupID AS PigGroupID,t.movementDate,
				t1.acctCode,tt.TranTypeID, 
				isnull(spg.PigGroupID,cast(' ' as char(10))) as SourcePigGroupID,
		        t.SourceProject
FROM  cftPMTranspRecord t 
			JOIN Batch b on t.BatchNbr=b.BatNbr  
			JOIN cftPMGradeQty q ON t.RefNbr = q.RefNbr 
			JOIN cftPigGradeAcct ga ON ga.PigGradeCatTypeID = q.PigGradeCatTypeID 
			JOIN cftPigAcct t1  ON ga.Acct = t1.acct
			JOIN cftPigAcctScrn scr on t1.acct=scr.acct and scr.ScrnNbr='XP13500'
			JOIN cftPigAcctTran tt on t1.acct=tt.acct and tt.TranTypeID=t.SubTypeID
			JOIN cftPigGroup d  ON t.DestPigGroupID=d.PigGroupID
		    LEFT JOIN cftPigGroup spg on t.SourcePigGroupID=spg.PigGroupID
		    
where 
t1.AffectEntity='D'
and t.DocType='TR'
and b.BatNbr=@parm1

UNION 
SELECT DISTINCT 
                q.Qty, t1.acct, t1.AffectEntity, t1.InvEffect, t.BatchNbr, t.RefNbr,
				t.SourceProject as Project , t.SourceTask as Task,
		        t.AvgWgt, q.LineNbr, q.PigGradeCatTypeID, 
                spg.PigGroupID AS PigGroupID,t.movementDate,
				t1.acctCode,tt.TranTypeID, 
				cast(' ' as char(10)) as SourcePigGroupID,
		        cast(' ' as char(10)) as SourceProject
FROM  cftPMTranspRecord t 
			JOIN Batch b on t.BatchNbr=b.BatNbr  
			JOIN cftPMGradeQty q ON t.RefNbr = q.RefNbr 
			JOIN cftPigGradeAcct ga ON ga.PigGradeCatTypeID = q.PigGradeCatTypeID 
			JOIN cftPigAcct t1  ON ga.Acct = t1.acct
			JOIN cftPigAcctScrn scr on t1.acct=scr.acct and scr.ScrnNbr='XP13500'
			JOIN cftPigAcctTran tt on t1.acct=tt.acct and tt.TranTypeID=t.SubTypeID
			LEFT JOIN cftPigGroup d  ON t.DestPigGroupID=d.PigGroupID
		    JOIN cftPigGroup spg on t.SourcePigGroupID=spg.PigGroupID
		    
where 
t1.AffectEntity='S'
and t.DocType='TR'
and b.BatNbr=@parm1

ORDER BY t.RefNbr,t1.AffectEntity, t1.acct
