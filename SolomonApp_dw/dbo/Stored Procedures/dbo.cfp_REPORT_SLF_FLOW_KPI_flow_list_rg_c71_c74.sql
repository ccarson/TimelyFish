














-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FLOW_KPI_ADG
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
-- 2014-12-16 sripley... user wanted to ignor c71,c72,c73,c74 until after 15wk00
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FLOW_KPI_flow_list_rg_c71_c74]
	@mg_week char(6)	
	
	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;

declare @pg_week char(6)
set @pg_week = @mg_week

declare @startday datetime
declare @start char(6)


-- get last date value for the selected week
select @startday = max(daydate) from  dbo.cftDayDefinition_WithWeekInfo	-- last daydate of the selected picyear_week (market date), used to determing the date - 6 months earlier
where picyear_week = @pg_week

select @start = picyear_week from  dbo.cftDayDefinition_WithWeekInfo	-- picyear_week value for 6 months earlier	(start of the market interval)
where daydate = dateadd(ww,-25,@startday)


--select ess.reportinggroupid ,   rg.[Reporting_Group_Description] + '     close weeks: '+ cast(count(distinct pg_week) as varchar(2) ) as Reporting_Group_Description
--from [dbo].[cft_SLF_ESSBASE_DATA] ess (nolock)
--  join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] rg (nolock)
--	on rg.reportinggroupid = ess.reportinggroupid
--where pg_week between case when @start = '99wk52' then '00wk01' else @start end  and @pg_week
--group by ess.reportinggroupid ,   rg.[Reporting_Group_Description]
--order by rg.[Reporting_Group_Description]

select ess.reportinggroupid ,   rg.[Reporting_Group_Description] + '     close weeks: '+ cast(count(distinct pg_week) as varchar(2) ) as Reporting_Group_Description
from [dbo].[cft_SLF_ESSBASE_DATA] ess (nolock)
  join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] rg (nolock)
	on rg.reportinggroupid = ess.reportinggroupid
where pg_week between case when @start = '99wk52' then '00wk01' else @start end  and @pg_week
and rg.[Reporting_Group_Description] not like '%c7%'
group by ess.reportinggroupid ,   rg.[Reporting_Group_Description]
union
select ess.reportinggroupid ,   rg.[Reporting_Group_Description] + '     close weeks: '+ cast(count(distinct pg_week) as varchar(2) ) as Reporting_Group_Description
from [dbo].[cft_SLF_ESSBASE_DATA] ess (nolock)
  join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] rg (nolock)
	on rg.reportinggroupid = ess.reportinggroupid
where pg_week between '15wk01'  and @pg_week
and rg.[Reporting_Group_Description] like '%c7%'
group by ess.reportinggroupid ,   rg.[Reporting_Group_Description]



END




















