
--*************************************************************
--	Purpose:Determines Production Type and ProdPod for a movement
--		
--	Author: Charity Anderson
--	Date: 7/25/2005
--	Usage: Transportation Module Sub UpdateProdPod 
--	Parms: PMID
--*************************************************************
/**
***************************************************************
	Updated for ticket 189
	Date: 02/05/2007
	Author: Dave Killion
	SP was changed to use a hard coded value of '01' 
	for the join on ts.pigsystemid
***************************************************************
**/

CREATE PROC dbo.pXT100SourceProdType
	(@parm1 as varchar(10))
AS
Select TOP 1 ProdType,ProductionPod, Sum(PodQty) as PodQty,
EstInventory=(Select sum(EstimatedQty) from cftPM where DestPigGroupID=temp.DestPigGroupID)
FROM
(
Select pm.DestPigGroupID,pp.ProdType,src.SourceContactID,ProductionPod=Case pp.ProdType when 'GRP' then
			pg.PigProdPodID
	 	when 'FAR' then
			(Select Top 1 PodID from cftSitePod where ContactID=src.SourceContactID
			and EffectiveDate<=src.MovementDate order by EffectiveDate DESC)
		when 'PUR' then
			pur.PodID end, 
		Sum(src.EstimatedQty) as PodQty
FROM cftPM pm 
JOIN cftPigTranSys ts on pm.TranSubTypeID=ts.TranTypeID and ts.PigSystemID = '01'
JOIN cftPigProdPhase pp on ts.SrcProdPhaseID=pp.PigProdPhaseID
LEFT JOIN cftPM src on pm.DestPigGroupID=src.DestPigGroupID
LEFT JOIN cftPigPurchase pur on pm.OrdNbr=pur.PPID
LEFT JOIN cftPigGroup pg on src.SourcePigGroupID=pg.PigGroupID
LEFT JOIN cftPigGroup d on pm.DestPigGroupID=d.PigGroupID
where pm.PMID=@parm1 and pm.DestPigGroupID>''
Group by  pm.DestPigGroupID,pp.ProdType,pg.PigProdPodID,src.SourceContactID,src.MovementDate,pur.PodID
)
as temp
Group by temp.DestPigGroupID,ProdType,ProductionPod
Order by PodQty Desc

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100SourceProdType] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT100SourceProdType] TO [MSDSL]
    AS [dbo];

