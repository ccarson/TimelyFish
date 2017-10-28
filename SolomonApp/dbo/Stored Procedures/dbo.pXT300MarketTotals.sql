
--*************************************************************

--	Purpose:Market Totals for a specific date and week
--	Author: Charity Anderson
--	Date: 3/22/2005
--	Usage: Transporation Module
--	Parms: Date, CpnyID, SundayDate
--	      
--*************************************************************
Create PROC [dbo].[pXT300MarketTotals]
		(@parm1 as smalldatetime,@parm2 as varchar(3), @parm3 as smalldatetime)

as
Select d.MarketTotalType,MarketDescription,TotalDay,TotalWeek
from 
(Select MarketDescription=Case mst.MarketTotalType
	when 'PRI' then 'Primary Market'
	when 'SEC' then 'Secondary Market'
	when 'NON' then 'Non-Market' end,mst.MarketTotalType,
	isnull(sum(pm.EstimatedQty),0) as TotalDay
	from cftMarketSaleType mst WITH (NOLOCK) 
	LEFT JOIN cftPM pm WITH (NOLOCK) on mst.MarketSaleTypeID=pm.MarketSaleTypeID and pm.MovementDate=@parm1
		and pm.PMSystemID like @parm2
and pm.SuppressFlg=0 and PMTYpeID='02' and (pm.Highlight <> 255 and pm.Highlight <> -65536)
		group by mst.MarketTotalType) as d

	JOIN (Select mst.MarketTotalType,
		isnull(sum(pm.EstimatedQty),0) as TotalWeek
		from cftMarketSaleType mst 
		LEFT JOIN cftPM pm on mst.MarketSaleTypeID=pm.MarketSaleTypeID 
		and pm.MovementDate between @parm3 and @parm3+6
		and pm.PMSystemID  like @parm2 and pm.SuppressFlg=0 and PMTYpeID='02' and (pm.Highlight <> 255 and pm.Highlight <> -65536)
		group by mst.MarketTotalType)as pt on pt.MarketTotalType=d.MarketTotalType
	
	


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT300MarketTotals] TO [MSDSL]
    AS [dbo];

