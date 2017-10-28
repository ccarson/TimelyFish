









-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_SiteEval_rpt1
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_SiteEval_rpt1]
@PicYear_Week char(6), @SiteContactid char(6)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
--	DECLARE @phase char(3)
	
--select top 1 @phase = phase from cft_rpt_pig_master_group_dw mpg (nolock)
--where picyear_week = @picyear_week and sitecontactid = @sitecontactid

--	DECLARE @EndDate char(6)
	
--select @enddate = picyear_week
--from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK)
--where daydate = (select top 1 DATEADD(d,-364,weekofdate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK) where PicYear_week = @picyear_week)

select area, definition, count(distinct eval_id) eval_cnt, min(entrydate) frsteval, max(entrydate) lasteval
, DATEDIFF(week,min(entrydate),max(entrydate))+1 as week_cnt
,	count(case when answer = 1 then 'yes' end) as yes_cnt,
	count(case when answer = 0 then 'no' end) as no_cnt,
	(cast(count(case when answer = 1 then 'yes' end) as float)/cast(count(1) as float))*100 yes_pct
from  cft_eval_dw ev (nolock)
left join 
	(SELECT picyear_week, sitecontactid, actstartdate, actclosedate
	 FROM [dbo].[cft_RPT_PIG_MASTER_GROUP_DW] (nolock)
	 where picyear_week = @PicYear_Week
	 and sitecontactid = @SiteContactid) pm 
		on pm.sitecontactid = ev.sitecontactid
where ev.sitecontactid = @SiteContactid
and ev.entrydate between pm.actstartdate and pm.actclosedate
group by area, definition
order by (cast(count(case when answer = 1 then 'yes' end) as float)/cast(count(1) as float))*100 desc, area


END
















GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_SiteEval_rpt1] TO [CorpReports]
    AS [dbo];

