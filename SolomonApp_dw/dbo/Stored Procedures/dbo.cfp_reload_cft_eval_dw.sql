



CREATE PROCEDURE [dbo].[cfp_reload_cft_eval_dw]
AS
BEGIN

-------------------------------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------------------------------
--clear table for new data
truncate table  dbo.cft_eval_dw

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
insert into cft_eval_dw
select se.eval_id, se.sitecontactid, se.SvcMgrContactID, se.entrydate, se.entryuserid,ser.question_id, ser.answer, que.QuestionNbr
, que.status, que.area, que.definition
,dw.[DayDate],dw.[DayName],dw.[PICCycle],dw.[PICDayNbr],dw.[WeekOfDate],dw.[FiscalPeriod],dw.[FiscalYear],dw.[PICWeek],dw.[PICYear],dw.[PICYear_Week],dw.[WeekEndDate]
,dw.[PICQuarter], dw.FYPeriod
from [$(SolomonApp)].[dbo].[cftSiteEval] se (nolock)
inner join [$(SolomonApp)].[dbo].[cftSiteEvalResults] ser (nolock)
	on ser.eval_id = se.eval_id
inner join [$(SolomonApp)].dbo.cftSiteQuestion que (nolock)
	on que.question_id = ser.question_id
inner join [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo] dw (nolock)
	on convert(char(10),dw.daydate,101) = convert(char(10),se.entrydate,101)


END



