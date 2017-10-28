
-- =============================================
-- Author:		Mike Zimanski
-- Create date: 12/14/2010
-- Description:	Returns all Start Periods
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_PL_STARTPERIOD_remove]
(
	 @EndPeriod		int
	   
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select distinct
	b.endgroupperiod as EndPeriod,
	Case When Right(rtrim(b.endgroupperiod),2)=12 then b.endgroupperiod-11 else b.endgroupperiod-99 end as StartPeriod,
	c.groupperiod as StartPeriod2

	from(
	
	select
	Case When Right(rtrim(a.groupperiod),2)=01 then a.groupperiod-89 else a.groupperiod-1 end as endgroupperiod

	from (
	select
	Case When wd.FiscalPeriod < 10 
	Then Rtrim(Cast(wd.FiscalYear as char))+'0'+Rtrim(Cast(wd.FiscalPeriod as char)) 
	else Rtrim(Cast(wd.FiscalYear as char))+Rtrim(Cast(wd.FiscalPeriod as char)) end As GroupPeriod

	from [$(SolomonApp)].dbo.cftWeekDefinition wd

	left join [$(SolomonApp)].dbo.cftDayDefinition dd
	on wd.weekofdate = dd.weekofdate

	where dd.daydate <= DateAdd(Day,0,DateDiff(Day,0,Current_TimeStamp))) a) b
	
	cross join 
	(select distinct 
	--Case When wd.FiscalPeriod < 10 
	--Then Rtrim(Cast(wd.FiscalYear-2 as char))+'0'+'01' 
	--else 
	Rtrim(Cast(wd.FiscalYear-2 as char))+'01' 
	--end 
	As GroupPeriod
	from [$(SolomonApp)].dbo.cftDayDefinition dd
	left join [$(SolomonApp)].dbo.cftWeekDefinition wd
	on dd.weekofdate = wd.weekofdate
	where Case When wd.FiscalPeriod < 10 
	Then Rtrim(Cast(wd.FiscalYear as char))+'0'+Rtrim(Cast(wd.FiscalPeriod as char)) 
	else Rtrim(Cast(wd.FiscalYear as char))+Rtrim(Cast(wd.FiscalPeriod as char)) end = @EndPeriod
	group by
	wd.FiscalYear,
	wd.FiscalPeriod) c
	
	where b.endgroupperiod = @EndPeriod

	order by 
	startperiod,
	endperiod,
	startperiod2
			
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_PL_STARTPERIOD_remove] TO [db_sp_exec]
    AS [dbo];

