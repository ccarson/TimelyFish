

/*
===============================================================================
Purpose: Market Totals for the Market Optimizer for a specific week
	Author: Doran Dahle, Steve Ripley
	Date: 7/29/2011
	Usage: Market Transporation Screen  XT.300.00
	Parms: SundayDate,CpnyID
	      
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-07-21  Doran Dahle initial release
2012-03-14  Doran Dahle Added Execute As to handle SL Integrated Security method
===============================================================================
*/
CREATE PROC [dbo].[pXT300MarketOptimizerTotals]
		(@sundayDate as smalldatetime, @CpnyID as varchar(3))
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
Select 3,mst.[Description]Description,
            isnull(sum(pm.EstimatedQty),0) as TotalWeek, mst.[MarketSaleTypeID] 
            from cftMarketSaleType mst (NOLOCK) 
            LEFT JOIN cftPM pm (NOLOCK) on mst.MarketSaleTypeID=pm.MarketSaleTypeID 
            INNER JOIN cftPigGroup PG (NOLOCK) ON PG.PigGroupID = PM.SourcePigGroupID
            and pm.MovementDate between @sundayDate and @sundayDate + 6
            and pm.PMSystemID like @CpnyID 
            and pg.PigProdPodID <> 49
            and pm.SuppressFlg=0 and PMTYpeID='02' and (pm.Highlight <> 255 and pm.Highlight <> -65536)
            group by mst.[MarketSaleTypeID], mst.[Description]
union 
Select 0,'Alternative Market' Description,isnull(sum(pm.EstimatedQty),0) as TotalWeek, 1
from cftMarketSaleType mst (NOLOCK)
LEFT JOIN cftPM pm (NOLOCK) on mst.MarketSaleTypeID=pm.MarketSaleTypeID 
INNER JOIN cftPigGroup PG (NOLOCK) ON PG.PigGroupID = PM.SourcePigGroupID
and pm.MovementDate between @sundayDate and @sundayDate + 6
and pm.PMSystemID like @CpnyID 
and pg.PigProdPodID <> 49
and pm.SuppressFlg=0 and PMTYpeID='02' and (pm.Highlight <> 255 and pm.Highlight <> -65536)
and pm.DestContactID = 816 and pm.MarketSaleTypeID in (10,20,25,30)
union 
Select 0,'280+' Description,isnull(sum(pm.EstimatedQty),0) as TotalWeek, 1
from cftMarketSaleType mst (NOLOCK) 
LEFT JOIN cftPM pm  (NOLOCK) on mst.MarketSaleTypeID=pm.MarketSaleTypeID 
INNER JOIN cftPigGroup PG (NOLOCK) ON PG.PigGroupID = PM.SourcePigGroupID
and pm.MovementDate between @sundayDate and @sundayDate + 6
and pm.PMSystemID like @CpnyID 
and pg.PigProdPodID <> 49
and pm.SuppressFlg=0 and PMTYpeID='02' and (pm.Highlight <> 255 and pm.Highlight <> -65536)
and pm.[EstimatedWgt] >= 280 and pm.MarketSaleTypeID in (10,20,25,30)
union
Select 0,'280-' Description,
isnull(sum(pm.EstimatedQty),0) as TotalWeek, 1
from cftMarketSaleType mst (NOLOCK) 
LEFT JOIN cftPM pm (NOLOCK) on mst.MarketSaleTypeID=pm.MarketSaleTypeID 
INNER JOIN cftPigGroup PG (NOLOCK) ON PG.PigGroupID = PM.SourcePigGroupID
and pm.MovementDate between @sundayDate and @sundayDate + 6
and pm.PMSystemID like @CpnyID 
and pg.PigProdPodID <> 49
and pm.SuppressFlg=0 and PMTYpeID='02' and (pm.Highlight <> 255 and pm.Highlight <> -65536)
and pm.[EstimatedWgt] < 280 and pm.MarketSaleTypeID in (10,20,25,30)
union
select 1,'non-Triumph' as Triumphflg,isnull(sum(dpg.TotalWeek),0) as TotalWeek, 1
from
(Select pm.sourcepiggroupid, isnull(sum(pm.EstimatedQty),0) as TotalWeek
from cftMarketSaleType mst (NOLOCK) 
 LEFT JOIN cftPM pm (NOLOCK) on mst.MarketSaleTypeID=pm.MarketSaleTypeID 
 INNER JOIN cftPigGroup PG (NOLOCK) ON PG.PigGroupID = PM.SourcePigGroupID
and pm.MovementDate between @sundayDate and @sundayDate + 6
and pm.SuppressFlg=0 and PMTYpeID='02' and (pm.Highlight <> 255 and pm.Highlight <> -65536)
and pm.MarketSaleTypeID in (10,20,25,30)
and pm.PMSystemID like @CpnyID 
where pg.PigProdPodID <> 49
group by pm.sourcepiggroupid) dpg
where exists
(SELECT piggroupid
      FROM SolomonApp.dbo.cftFeedOrder (NOLOCK)
      WHERE Reversal='0' and InvtIdDel is not null
      and charindex(ltrim(rtrim(InvtIdDel)+'|'),(select feedration from CFApp.dbo.cft_PACKER_BYPASS where contactid = '002936')) > 0
      and InvtIdDel > ''
      and piggroupid = dpg.sourcepiggroupid)
union
select 1,'Triumph' as Triumphflg, isnull(sum(dpg.TotalWeek),0) as TotalWeek, 1
from
(Select pm.sourcepiggroupid, isnull(sum(pm.EstimatedQty),0) as TotalWeek
from cftMarketSaleType mst (NOLOCK) 
 LEFT JOIN cftPM pm (NOLOCK) on mst.MarketSaleTypeID=pm.MarketSaleTypeID 
 INNER JOIN cftPigGroup PG (NOLOCK) ON PG.PigGroupID = PM.SourcePigGroupID
and pm.MovementDate between @sundayDate and @sundayDate + 6
and pm.PMSystemID like @CpnyID 
and pm.SuppressFlg=0 and PMTYpeID='02' and (pm.Highlight <> 255 and pm.Highlight <> -65536)
and pm.MarketSaleTypeID in (10,20,25,30)
where pg.PigProdPodID <> 49
group by pm.sourcepiggroupid) dpg
where not exists
(SELECT piggroupid
      FROM SolomonApp.dbo.cftFeedOrder (NOLOCK)
      WHERE Reversal='0' and InvtIdDel is not null
      and charindex(ltrim(rtrim(InvtIdDel)+'|'),(select feedration from CFApp.dbo.cft_PACKER_BYPASS where contactid = '002936')) > 0
      and InvtIdDel > ''
      and piggroupid = dpg.sourcepiggroupid)
order by 1,4




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT300MarketOptimizerTotals] TO [MSDSL]
    AS [dbo];

