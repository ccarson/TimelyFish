


CREATE PROCEDURE [dbo].[cfp_REPORT_SITE_EVAL_SYSTEM_BY_PIC_DATE]
	@PicDate CHAR(6)
,	@NumWeeks int
AS

---------------------------------------------------------------------
--pic dates
---------------------------------------------------------------------
DECLARE @PicYear char(4)
DECLARE @PicWeek char(2)
DECLARE @PicStartDate datetime
DECLARE @PicStartDateSingle datetime
DECLARE @PicEndDate datetime
SET @PicYear = '20' + LEFT(@PicDate,2)
SET @PicWeek = RIGHT(@PicDate,2)

SELECT @PicEndDate = WeekEndDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE PicYear = CAST(@PicYear AS INT) AND PicWeek = CAST(@PicWeek AS INT)
SELECT @PicStartDate = WeekOfDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE DATEADD(wk,-@NumWeeks,@PicEndDate) BETWEEN WeekOfDate AND WeekEndDate

Select
sc.ContactName as 'Site',
ft.Description as 'Phase',
svc.ContactName as 'SvcMgr',
sq.Area,
sq.Definition as 'Question',
dw.PICYear_Week,
Sum(Convert(int,ser.Answer)) as 'Yes',
Count(se.Eval_id) - Sum(Convert(int,ser.Answer)) as 'No',
Count(se.Eval_id) as 'Evaluations'

From [$(SolomonApp)].dbo.cftSiteEval se
left join [$(SolomonApp)].dbo.cftSiteEvalResults ser
on se.Eval_id = ser.Eval_id
left join [$(SolomonApp)].dbo.cftSiteQuestion sq
on ser.Question_id = sq.Question_id
left join [$(SolomonApp)].dbo.cftContact sc
on se.SiteContactID = sc.ContactID 
left join [$(SolomonApp)].dbo.cftSite s
on sc.ContactID = s.ContactID
left join [$(SolomonApp)].dbo.cftFacilityType ft
on s.FacilityTypeID = ft.FacilityTypeID 
left join [$(SolomonApp)].dbo.cftContact svc
on se.SvcMgrContactID = svc.ContactID 
left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw
on Convert(date,se.EntryDate) = dw.DayDate 

Where sq.status = 'A'
and Convert(date,se.EntryDate) between @PicStartDate and @PicEndDate

Group by
sc.ContactName,
ft.Description,
svc.ContactName,
sq.Area,
sq.Definition,
dw.PICYear_Week,
se.EntryDate


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SITE_EVAL_SYSTEM_BY_PIC_DATE] TO [db_sp_exec]
    AS [dbo];

