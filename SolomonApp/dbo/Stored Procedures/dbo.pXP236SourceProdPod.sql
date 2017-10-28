--*************************************************************
--	Purpose:Determines Production Type and ProdPod for a movement
--		
--	Author: Charity Anderson
--	Date: 7/25/2005
--	Usage: Transportation Module Sub UpdateProdPod 
--	Parms: PMID
--*************************************************************

CREATE PROC dbo.pXP236SourceProdPod
	(@parm1 as varchar(10))
AS
Select ProductionPod,sum(qty) as PodQty,
	TotalQty=(Select sum(inveffect * Qty) from cftPGInvTran 
		where PigGroupID=@parm1 and Reversal=0 and 
		TranTypeID in ('TI', 'MI','PP')),
	PodPct= cast(cast((sum(temp.qty * 100.00) /(Select sum(inveffect * Qty) from cftPGInvTran 
		where PigGroupID=@parm1 and Reversal=0 and 
		TranTypeID in ('TI', 'MI','PP'))) as decimal(5,2)) as varchar(6)),
pp.Description as ProdPodName

  from 
(Select DISTINCT tr.PMID,xf.SourceRefNbr,xf.SourceLineNbr,
ProductionPod=Case pp.ProdType when 'GRP' then
			pg.PigProdPodID
		when 'PUR' then pur.PodID 
		else (Select Top 1 PodID from cftSitePod sp 
				JOIN cftSite s on sp.ContactID=s.ContactID
				 where 'PS'+ rtrim(s.SiteID)=xf.SourceProject
			and EffectiveDate<=xf.TranDate order by EffectiveDate DESC)end, 
		xf.Qty,xf.acct,
       xf.TranDate,
	   SourceID=cast(isnull(pg.PigGroupID, pj.project) as varchar(10)),
       Source=cast(isnull(pg.description,pj.project_desc) as varchar(30))
FROM cftPGInvTran xf 
LEFT JOIN cftPMTranspRecord tr on xf.SourceBatNbr=tr.BatchNbr and xf.SourceRefNbr=tr.RefNbr
LEFT JOIN cftPM pm on tr.PMID=pm.PMID
LEFT JOIN cftPigTranSys ts on tr.SubTypeID=ts.TranTypeID 
LEFT JOIN cftPigProdPhase pp on ts.SrcProdPhaseID=pp.PigProdPhaseID
LEFT JOIN cftPigPurchase pur on pm.OrdNbr=pur.PPID
LEFT JOIN cftPigGroup pg on xf.SourcePigGroupID=pg.PigGroupID
JOIN pjproj pj on xf.SourceProject=pj.project

where xf.PigGroupID=@parm1 and xf.Reversal=0 and xf.TranTypeID in ('TI', 'MI','PP') ) as temp
LEFT JOIN cftPigProdPod pp on temp.ProductionPod=pp.PodID
Group by ProductionPod,pp.Description


 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP236SourceProdPod] TO [MSDSL]
    AS [dbo];

