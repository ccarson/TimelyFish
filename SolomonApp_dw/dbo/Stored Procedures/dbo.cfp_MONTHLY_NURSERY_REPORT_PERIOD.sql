

CREATE PROCEDURE [dbo].[cfp_MONTHLY_NURSERY_REPORT_PERIOD]
(	
	@FYPeriod CHAR(6)
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Select
	
	DW.StartPeriod,
	DW.EndPeriod,
	DW.FYPeriod,
	Min(FW.DayDate) SysStartPeriod
	
	From(	
	
	Select 
	
	Min(DayDate) as StartPeriod,
	Max(DayDate) as EndPeriod,
	Case when FiscalPeriod < 10 
	then Rtrim(CAST(FiscalYear AS char)) + '0' + Rtrim(CAST(FiscalPeriod AS char)) 
	else Rtrim(CAST(FiscalYear AS char)) + Rtrim(CAST(FiscalPeriod AS char)) end FYPeriod

	From [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
	
	Where Case when FiscalPeriod < 10 
	then Rtrim(CAST(FiscalYear AS char)) + '0' + Rtrim(CAST(FiscalPeriod AS char)) 
	else Rtrim(CAST(FiscalYear AS char)) + Rtrim(CAST(FiscalPeriod AS char)) end = @FYPeriod
	
	Group by
	FiscalPeriod,
	FiscalYear) DW
	
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo FW
	on Case when right(rtrim(DW.FYPeriod),2) = 12 then DW.FYPeriod - 11 else DW.FYPeriod - 99 end = 
	Case when FW.FiscalPeriod < 10 
	then Rtrim(CAST(FW.FiscalYear AS char)) + '0' + Rtrim(CAST(FW.FiscalPeriod AS char)) 
	else Rtrim(CAST(FW.FiscalYear AS char)) + Rtrim(CAST(FW.FiscalPeriod AS char)) end
	
	Group by
	DW.StartPeriod,
	DW.EndPeriod,
	DW.FYPeriod
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MONTHLY_NURSERY_REPORT_PERIOD] TO [db_sp_exec]
    AS [dbo];

