
--*************************************************************
--	Purpose:Determines Production Type and ProdPod for a TransportRecord
--		
--	Author: Charity Anderson
--	Date: 7/26/2005
--	Usage: Pig Transport Batch Release Module
--	Parms: RefNbr
--*************************************************************

CREATE PROC dbo.pXP135SourceProdType
	(@parm1 as varchar(10))
AS
/* Select  isnull(ProductionPod,'') as PodID
from
(Select  Distinct ProductionPod=Case pp.ProdType when 'GRP' then
			pg.PigProdPodID
	 	when 'FAR' then
			(Select Top 1 PodID from cftSitePod where ContactID=pm.SourceContactID
			and EffectiveDate<=pm.MovementDate order by EffectiveDate DESC)
		when 'PUR' then
			pur.PodID end
FROM cftPMTranspRecord pm 
JOIN cftPM tpm on pm.PMID=tpm.PMID
JOIN cftPigTranSys ts on pm.SubTypeID=ts.TranTypeID
JOIN cftPigProdPhase pp on ts.SrcProdPhaseID=pp.PigProdPhaseID
LEFT JOIN cftPGInvTran src on pm.DestPigGroupID=src.PigGroupID and InvEffect=1
LEFT JOIN cftPigPurchase pur on tpm.OrdNbr=pur.PPID
LEFT JOIN cftPigGroup pg on src.SourcePigGroupID=pg.PigGroupID
where pm.RefNbr=@parm1) as t */

Select TOP 1 ProdType,ProductionPod, Sum(PodQty) as PodQty,EstInventory
FROM
(
Select pp.ProdType,src.SourceContactID,ProductionPod=Case pp.ProdType when 'GRP' then
			pg.PigProdPodID
	 	when 'FAR' then
			(Select Top 1 PodID from cftSitePod where ContactID=src.SourceContactID
			and EffectiveDate<=src.MovementDate order by EffectiveDate DESC)
		when 'PUR' then
			pur.PodID end, 
		Sum(src.EstimatedQty) as PodQty,
		EstInventory=(Select EstInventory from cftPigGroup where PigGroupID=pm.DestPigGroupID)
FROM cftPMTranspRecord pm 
JOIN cftPM tpm on pm.PMID=tpm.PMID
JOIN cftPigTranSys ts on pm.SubTypeID=ts.TranTypeID 
JOIN cftPigProdPhase pp on ts.SrcProdPhaseID=pp.PigProdPhaseID
LEFT JOIN cftPM src on pm.DestPigGroupID=src.DestPigGroupID
LEFT JOIN cftPigPurchase pur on tpm.OrdNbr=pur.PPID
LEFT JOIN cftPigGroup pg on src.SourcePigGroupID=pg.PigGroupID
LEFT JOIN cftPigGroup d on pm.DestPigGroupID=d.PigGroupID
where pm.RefNbr=@parm1 and pm.DestPigGroupID>''
Group by  pm.DestPigGroupID,pp.ProdType,pg.PigProdPodID,src.SourceContactID,src.MovementDate,pur.PodID)
as temp
Group by ProdType,ProductionPod, EstInventory
Order by PodQty Desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135SourceProdType] TO [MSDSL]
    AS [dbo];

