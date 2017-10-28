
-- =============================================
-- Author:		Mike Zimanski
-- Create date: 01/19/2011
-- Description:	Returns all Start Periods
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SITE_EVALUATION_SUMMARY_STARTPERIOD]
(
	 @EndPICYrWeek	varchar(8000)
	   
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select Distinct

	right(wd.PICYear,2) + 'WK' + replicate('0',2-len(rtrim(convert(char(2),rtrim(wd.PICWeek)))))
	+ rtrim(convert(char(2),rtrim(wd.PICWeek))) EndPICYrWeek,
	right(wd2.PICYear,2) + 'WK' + replicate('0',2-len(rtrim(convert(char(2),rtrim(wd2.PICWeek)))))
	+ rtrim(convert(char(2),rtrim(wd2.PICWeek))) StartPICYrWeek

	from [$(SolomonApp)].dbo.cftDayDefinition dd
	
	left join [$(SolomonApp)].dbo.cftWeekDefinition wd
	on dd.weekofdate = wd.weekofdate

	left join [$(SolomonApp)].dbo.cftDayDefinition dd2
	on wd.weekofdate-365 = dd2.daydate

	left join [$(SolomonApp)].dbo.cftWeekDefinition wd2
	on dd2.weekofdate = wd2.weekofdate

	Where right(wd.PICYear,2) + 'WK' + replicate('0',2-len(rtrim(convert(char(2),rtrim(wd.PICWeek)))))
	+ rtrim(convert(char(2),rtrim(wd.PICWeek))) = @EndPICYrWeek
			
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_EVALUATION_SUMMARY_STARTPERIOD] TO [db_sp_exec]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[cfp_SITE_EVALUATION_SUMMARY_STARTPERIOD] TO [db_sp_exec]
    AS [dbo];

