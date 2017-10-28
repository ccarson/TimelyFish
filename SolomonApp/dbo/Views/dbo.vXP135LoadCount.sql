--*************************************************************
--	Purpose:Count Pig Transports by LoadID and Source/Destination	
--	Author: Charity Anderson
--	Date: 10/27/2005
--	Usage: TransportRecord Entry Batch Release
--	Parms: none
--	      
--*************************************************************

CREATE  VIEW dbo.vXP135LoadCount

AS
Select  Distinct tr.RefNbr, pm.PMLoadID, tr.PMID, LoadCount, tr.DocType,
		tr.SourceProject, tr.SourceTask, tr.DestProject, tr.DestTask
from cftPMTranspRecord tr 
JOIN cftPM pm on tr.PMID=pm.PMID
LEFT JOIN
(Select PMLoadID, Count(*) as LoadCount 
from 
(Select  pmx.PMLoadID, trx.PMID, trx.SourceProject,trx.SourceTask, 
	trx.DestProject,trx.DestTask
from cftPMTranspRecord trx join cftPM pmx on trx.PMID=pmx.PMID
LEFT JOIN cftPMTranspRecord rev on trx.RefNbr=rev.OrigRefNbr
JOIN Batch b on trx.BatchNbr=b.BatNbr and b.Module='XP'
where rev.RefNbr is null and trx.DocType='TR' ) as t

group by PMLoadID) as c on pm.PMLoadID=c.PMLoadID
