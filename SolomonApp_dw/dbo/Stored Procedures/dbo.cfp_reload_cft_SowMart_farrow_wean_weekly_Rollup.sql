







CREATE PROCEDURE [dbo].[cfp_reload_cft_SowMart_farrow_wean_weekly_Rollup]
AS
BEGIN

SET ANSI_WARNINGS OFF;
declare @farmid varchar(30)

truncate table [dbo].[cft_SowMart_farrow_wean_weekly_Rollup]

insert into [dbo].[cft_SowMart_farrow_wean_weekly_Rollup]
select farrow_picyear_week as picyear_week, pigflowid, reportinggroupid,farmid, siteid
, sum(total_born_qty) total_born_qty
, sum(born_alive_qty) born_alive_qty
, sum(mummy_qty) mummy_qty
, sum(stillborn_qty) stillborn_qty
, sum(pigletdeath_qty) pigletdeath_qty
, sum(nurseon_qty) nurseon_qty
, count(identityid) litters_farrowed_qty
, null wean_qty
, null litters_weaned_qty
, null avg_wean_age
, 100*(sum(cast(born_alive_qty as float))/sum(cast(total_born_qty as float))) born_alive_pct
, 100*(sum(cast(mummy_qty as float))/sum(cast(total_born_qty as float))) mummy_pct
, 100*(sum(cast(stillborn_qty as float))/sum(cast(total_born_qty as float))) stillborn_pct
, 100*(sum(cast(pigletdeath_qty as float))/sum(cast(total_born_qty as float))) pigletdeath_pct
, 100*(sum(cast(nurseon_qty as float))/sum(cast(total_born_qty as float))) nurseon_pct
, null wean_pct --100*(sum(cast(wean_qty as float))/sum(cast(total_born_qty as float))) wean_pct
, null litters_farrowed_pct
,  null litters_weaned_pct
, getdate()
, null
, null
, null
from  [dbo].[cft_SowMart_Detail_data] 
where farrow_picyear_week is not null
and total_born_qty > 0
and pigflowid is not null 
and reportinggroupid is not null
group by farrow_picyear_week,farmid, siteid, pigflowid, reportinggroupid

-- rowsins  (18568 row(s) affected)   16 seconds

update [dbo].[cft_SowMart_farrow_wean_weekly_Rollup]
set wean_qty = updt.wean_qty, litters_weaned_qty = updt.litters_weaned_qty, avg_wean_age = updt.avg_wean_age
, min_wean_age = updt.min_wean_age
, max_wean_age = updt.max_wean_age
, stddev_wean_age = updt.stddev_wean_age
from [dbo].[cft_SowMart_farrow_wean_weekly_Rollup] ms
join 
(select final_wean_picyear_week as picyear_week,farmid, siteid, pigflowid, reportinggroupid
, sum(wean_qty) wean_qty
, count(identityid) litters_weaned_qty
, avg(wean_age) avg_wean_age
, (count(identityid)*1.0)/(count(final_wean_picyear_week)*1.0) litters_farrow2wean_pct
, min(wean_age) min_wean_age
, max(wean_age) max_wean_age
, stdev(wean_age) stddev_wean_age
from  [dbo].[cft_SowMart_Detail_data] 
group by final_wean_picyear_week, farmid, siteid, pigflowid, reportinggroupid
having count(final_wean_picyear_week) > 0) updt
	on ms.picyear_week = updt.picyear_week 
	and ms.farmid = updt.farmid
	and ms.siteid = updt.siteid
	and ms.pigflowid = updt.pigflowid
	and ms.reportinggroupid = updt.reportinggroupid


end









