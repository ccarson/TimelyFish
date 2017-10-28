--*************************************************************
--	Purpose:Relates pig sale detail from Swift and Hormel to the Pig Group
--	Author: Charity Anderson
--	Date: 8/19/2005
--	Usage: Brent Frederick and Analyst Dept 
--	Parms: BeginKillDate, EndKillDate, PigGroupGender, PigGroupQtyPct
--*************************************************************

CREATE PROC dbo.pXSPSPigGroupDetail
(@parm1 as smalldatetime, @parm2 as smalldatetime, @parm3 as varchar(2), @parm4 as float, @parm5 as varchar(10), @parm6 as varchar(3))
AS

Select psdet.* from
--Swift 
(Select   ps.PigGroupID,pg.Description as PigGroupName,pp.PodID,  pp.Description as ProductionPod,
psd.HotWeight, psd.Fat, psd.LeanPct, psd.LoinEyeDepth, psd.KillDate, pg.PigGenderTypeID

from cftPSDetSwift psd
JOIN cftPigSale ps on psd.TattooNbr=ps.TattooNbr and ps.CUSTID='SWIFT'  and ps.KillDate=psd.KillDate
		and ps.DocType<>'RE' and ps.SaleTypeID<>'RS'
LEFT JOIN cftPigSale rev on ps.RefNbr=rev.OrigRefNbr 
		
JOIN cftPIgGroup pg on ps.PigGroupID=pg.PigGroupID
JOIN cftPigProdPod pp on pg.PigProdPodID=pp.PodID

where rev.RefNbr is null and  psd.KillDate between @parm1 and @parm2
and pg.PigGenderTypeID like @parm3

UNION ALL
Select   ps.PigGroupID,pg.Description as PigGroupName, pp.PodID, pp.Description as ProductionPod,
psd.CarcassWgt, hg.BackFatPct*25.4,0, 0,psd.KillDate, pg.PigGenderTypeID
from cftPSDetHormel psd
JOIN cftPigSale ps on psd.TattooNbr=ps.TattooNbr and ps.CUSTID='HOR'  and ps.KillDate=psd.KillDate
		and ps.DocType<>'RE' and ps.SaleTypeID<>'RS'
LEFT JOIN cftPigSale rev on ps.RefNbr=rev.OrigRefNbr 
		
JOIN cftPIgGroup pg on ps.PigGroupID=pg.PigGroupID
JOIN cftPigProdPod pp on pg.PigProdPodID=pp.PodID
LEFT JOIN cftHormelGrade hg on psd.GradeCode=hg.GradeCode

where rev.RefNbr is null and  psd.KillDate between @parm1 and @parm2
and pg.PigGenderTypeID like @parm3) as PSDet



JOIN (Select PigGroupID, sum(qty*InvEffect) as SaleQty
		from cftPGInvTran where Reversal=0 and acct<>'PIG SALE'
		Group by PigGroupID) as Sale on PSDet.PigGroupID=sale.PigGroupID

JOIN (Select Distinct ps.PigGroupID, count(RecordID) as SwiftQty
		from cftPSDetSwift psd
		JOIN cftPigSale ps on psd.TattooNbr=ps.TattooNbr and ps.CUSTID='SWIFT'  and ps.KillDate=psd.KillDate
		and ps.DocType<>'RE' and ps.SaleTypeID<>'RS'
		LEFT JOIN cftPigSale rev on ps.RefNbr=rev.OrigRefNbr 
		where rev.RefNbr is null 
		Group by ps.PigGroupID) as cnt on cnt.PigGroupID=PSDet.PigGroupID	
JOIN  (Select Distinct ps.PigGroupID, count(RecordID) as HormelQty
		from cftPSDetHormel psd
		JOIN cftPigSale ps on psd.TattooNbr=ps.TattooNbr and ps.CUSTID='HOR'  and ps.KillDate=psd.KillDate
		and ps.DocType<>'RE' and ps.SaleTypeID<>'RS'
		LEFT JOIN cftPigSale rev on ps.RefNbr=rev.OrigRefNbr 
		where rev.RefNbr is null
		Group by ps.PigGroupID) as HormCnt on HormCnt.PigGroupID=PSDet.PigGroupID	

Where (HormelQty+SwiftQty)/SaleQty>=@parm4 and psdet.PigGroupID like @parm5 and PodID like @parm6



 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXSPSPigGroupDetail] TO [MSDSL]
    AS [dbo];

