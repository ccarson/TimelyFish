--*************************************************************
--	Purpose:Converts PMTranspRecords to InvTran records
--	Author: Charity Anderson
--	Date: 9/8/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (BatchNbr)
--	      
--*************************************************************

CREATE PROC dbo.pCF507InvTranXfer
	@parm1 as varchar(6)

AS
SELECT DISTINCT 
		      InvEffect=Case when t.DocType='RE' then a.ca_id10 * -1
				else a.ca_id10 end,
                      q.Qty, t1.acct, 
a.ca_id04, a.ca_id10, t.BatchNbr, 
                      t.RefNbr, t.DestProject as Project , t.DestTask as Task,
		      t.AvgWgt, q.LineNbr, q.PigGradeCatTypeID, 
                      d.PigGroupID AS PigGroupID,t.movementDate,
			t1.trantypeID ,
			t.SubTypeID, isnull(spg.PigGroupID,cast(' ' as char(10))) as SourcePigGroupID,
		      t.SourceProject
FROM         cftPigGradeAcct ga INNER JOIN
                      Batch b INNER JOIN
                      cftPMTranspRecord t ON b.BatNbr = t.BatchNbr INNER JOIN
                      cftPMGradeQty q ON t.BatchNbr = q.BatchNbr AND 
                      t.RefNbr = q.RefNbr ON 
                      ga.PigGradeCatTypeID = q.PigGradeCatTypeID INNER JOIN
                      cftPGInvTType t1  ON ga.Acct = t1.acct OR t1.acct IS NULL INNER JOIN
                      PJACCT a ON ga.Acct = a.acct LEFT OUTER JOIN
                      cftPigGroup d  ON t.DestProject = d.ProjectID AND 
                      t.DestTask = d.TaskID
		      LEFT JOIN cftPGTTypeScr scr on t1.TranTypeID=scr.TranTypeID and scr.ScreenNbr='CF50700'
		      LEFT JOIN cftPigGroup spg on t.SourceTask=spg.TaskID
		      JOIN cftPGInvTSub sub on t1.TranTypeID=sub.TranTypeID and sub.SubTypeID=t.SubTypeID
where 
d.PigGroupID is not null and 
a.ca_id04='D'
and t.DocType='TR'
and b.BatNbr=@parm1
		      

UNION 
SELECT DISTINCT 
                      InvEffect=Case when t.DocType='RE' then a.ca_id10 * -1
				else a.ca_id10 end,
		      q.Qty, t1.acct,
 a.ca_id04, a.ca_id10, t.BatchNbr, 
                      t.RefNbr, t.SourceProject as Project, 
                      t.SourceTask as Task, t.AvgWgt, q.LineNbr, q.PigGradeCatTypeID, 
                      s.PigGroupID AS PigGroupID, t.MovementDate, t1.trantypeID, t.SubTypeID,
		      '' as SourcePigGroupID,'' as SourceProject
FROM         cftPigGradeAcct ga INNER JOIN
                      Batch b INNER JOIN
                      cftPMTranspRecord t ON b.BatNbr = t.BatchNbr INNER JOIN
                      cftPMGradeQty q ON t.BatchNbr = q.BatchNbr AND 
                      t.RefNbr = q.RefNbr ON 
                      ga.PigGradeCatTypeID = q.PigGradeCatTypeID INNER JOIN
                      cftPGInvTType t1  ON ga.Acct = t1.acct OR t1.acct IS NULL INNER JOIN
                      PJACCT a ON ga.Acct = a.acct LEFT OUTER JOIN
                      cftPigGroup s  ON t.SourceProject = s.ProjectID AND 
                      t.SourceTask = s.TaskID
		      JOIN cftPGTTypeScr scr on (t1.TranTypeID=scr.TranTypeID and scr.ScreenNbr='CF50700')
		      LEFT JOIN cftPGInvTSub sub on (t1.TranTypeID=sub.TranTypeID and sub.SubTypeID=t.SubTypeID and sub.SubTypeID is not null)
              
		      where 
s.PigGroupID is not null and 
a.ca_id04='S'
and t.DocType='TR'
		      and b.BatNbr=@parm1
ORDER BY a.ca_id04, t1.acct


 