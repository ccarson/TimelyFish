
-- =============================================
-- Author:		Mike Zimanski
-- Create date: 10/20/2011
-- Description:	Returns all Start Periods
-- =============================================
CREATE PROCEDURE [dbo].[cfp_HR_TURNOVER_REPORT_STARTPERIOD]
(
	 @EndPeriod		varchar(50)
	   
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select 

	SP.FY_Per as 'StartPeriod',
	EP.FY_Per as 'EndPeriod'

	From (

	Select Distinct

	Case When FiscalPeriod < 10 
	Then Rtrim(Cast(FiscalYear as char))+'0'+Rtrim(Cast(FiscalPeriod as char)) 
	else Rtrim(Cast(FiscalYear as char))+Rtrim(Cast(FiscalPeriod as char)) end As GroupPeriod,
	right(rtrim(cast(FiscalYear as char)),2) + 'Per' +
	Replicate('0', 2 - Len(rtrim(Convert(char(2), rtrim(FiscalPeriod)))))
	+
	rtrim(Convert(char(2), rtrim(
	(FiscalPeriod)))) as 'FY_Per'

	from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo

	where FiscalYear >= 2008
	and DayDate <= DateAdd(Day,0,DateDiff(Day,0,Current_TimeStamp))) EP

	left join (

	Select Distinct

	Case When FiscalPeriod < 10 
	Then Rtrim(Cast(FiscalYear as char))+'0'+Rtrim(Cast(FiscalPeriod as char)) 
	else Rtrim(Cast(FiscalYear as char))+Rtrim(Cast(FiscalPeriod as char)) end As GroupPeriod,
	right(rtrim(cast(FiscalYear as char)),2) + 'Per' +
	Replicate('0', 2 - Len(rtrim(Convert(char(2), rtrim(FiscalPeriod)))))
	+
	rtrim(Convert(char(2), rtrim(
	(FiscalPeriod)))) as 'FY_Per'

	from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo) SP

	on Case When Right(rtrim(EP.GroupPeriod),2)=12 then EP.GroupPeriod-11 else EP.GroupPeriod-99 end = SP.GroupPeriod

	Where EP.FY_Per = @EndPeriod

	Order by
	EP.FY_Per desc

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_HR_TURNOVER_REPORT_STARTPERIOD] TO [db_sp_exec]
    AS [dbo];

