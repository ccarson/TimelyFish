--*************************************************************
--	Purpose:Determines Production Type and ProdPod for a movement
--		
--	Author: Charity Anderson
--	Date: 8/31/2005
--	Usage: Transportation Module Sub UpdateProdPodAll
--	Parms: PigGroupID
--*************************************************************

CREATE PROC dbo.pXT100PGSourceProdType
	(@parm1 as varchar(10))
AS
Select TOP 1 ProdType,ProductionPod, Sum(PodQty) as PodQty,
EstInventory=(Select sum(EstimatedQty) from cftPM where DestPigGroupID=temp.PigGroupID)
FROM
(
Select d.PigGroupID,pp.ProdType,src.SourceContactID,ProductionPod=Case pp.ProdType when 'GRP' then
			pg.PigProdPodID
	 	when 'FAR' then
			(Select Top 1 PodID from cftSitePod where ContactID=src.SourceContactID
			and EffectiveDate<=src.MovementDate order by EffectiveDate DESC)
		when 'PUR' then
			pur.PodID end, 
		Sum(src.EstimatedQty) as PodQty
FROM  cftPigGroup d
JOIN cftPM src on src.DestPigGroupID=d.PigGroupID
JOIN cftPigTranSys ts on src.TranSubTypeID=ts.TranTypeID and src.PMSystemID=ts.PigSystemID
JOIN cftPigProdPhase pp on ts.SrcProdPhaseID=pp.PigProdPhaseID
LEFT JOIN cftPigPurchase pur on src.OrdNbr=pur.PPID
LEFT JOIN cftPigGroup pg on src.SourcePigGroupID=pg.PigGroupID
where d.PigGroupID=@parm1
Group by  d.PigGroupID,pp.ProdType,pg.PigProdPodID,src.SourceContactID,src.MovementDate,pur.PodID
)
as temp
Group by temp.PigGroupID,ProdType,ProductionPod
Order by PodQty Desc


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100PGSourceProdType] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT100PGSourceProdType] TO [MSDSL]
    AS [dbo];

