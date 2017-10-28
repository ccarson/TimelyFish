--*************************************************************
--	Purpose:Count Pig Transports by LoadID and Source	
--	Author: Charity Anderson
--	Date: 10/27/2005
--	Usage: TransportRecord Entry Batch Release
--	Parms: none
--	      
--*************************************************************

CREATE  VIEW dbo.vXP135LoadSourceCount

AS
Select Distinct tr.PMID, SourceCount
from cftPMTranspRecord tr 
JOIN cftPM pm on tr.PMID=pm.PMID
JOIN
(Select PMLoadID, Count(SourceContactID) as SourceCount 
from 
(Select Distinct pmx.PMLoadID, trx.PMID, trx.SourceContactID, trx.DestContactID
from cftPMTranspRecord trx join cftPM pmx on trx.PMID=pmx.PMID
LEFT JOIN cftPMTranspRecord rev on trx.RefNbr=rev.OrigRefNbr
JOIN Batch b on trx.BatchNbr=b.BatNbr and b.Module='XP'
where rev.RefNbr is null and trx.DocType='TR') as t
group by PMLoadID) as c on pm.PMLoadID=c.PMLoadID
