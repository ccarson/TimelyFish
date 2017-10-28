
-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_rpt4
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
create PROCEDURE [dbo].[cfp_REPORT_SLF_rpt3_picquarter]
	@picquarter char(7)
	
	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;
	
select 
site, siteid
, sum(farrows) farrows
, sum(bornalive)+Sum(StillBorn)+Sum(Mummy) TotBorn
, sum(bornalive) bornalive
, Sum(StillBorn) StillBorn
, 100*(sum(cast(stillborn as float))/ (sum(cast(bornalive as float))+Sum(cast(StillBorn as float))+Sum(cast(Mummy as float)))) pctSB
, Sum(Mummy) Mummy
, 100*(sum(cast(mummy as float))/(sum(cast(bornalive as float))+Sum(cast(StillBorn as float))+Sum(cast(Mummy as float)))) pctMum
, Sum(ServeFarrow) ServeFarrow, sum(sowdays)/365 [Female Inventory]
, sum(cast(FarrowTarget as float))/52 [farrowtarget/week]
, (sum(cast(bornalive as float))+Sum(cast(StillBorn as float))+Sum(cast(Mummy as float)))/sum(cast(farrows as float)) [Total Born/Litter]
, sum(cast(bornalive as float))/sum(cast(farrows as float)) [Total BA/Litter]
, sum(cast(farrows as float))/sum(cast(ServeFarrow as float))*100 farrowrate
, sum(goodpigs) goodpigs
, sum(sowweaned) sowweaned
, sum(cast(goodpigs as float))/sum(cast(sowweaned as float)) [pigs weaned/litter]
, min(kpi.fyperiod) minfyperiod
, max(kpi.fyperiod) maxfyperiod
from  dbo.cft_SOW_SERVICEMGR_KPI_RESULTS kpi (nolock)
left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dv
	on dv.fyperiod = substring(kpi.fyperiod,3,2)+'Per'+right(kpi.fyperiod,2)
where dv.picquarter = @picquarter
group by site, siteid
order by site	


END
















