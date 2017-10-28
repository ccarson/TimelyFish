
-- =============================================
-- Author:		Mike Zimanski
-- Create date: 1/18/2011
-- Description:	Returns all Truckers
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_DRIVER_LOAD_INFORMATION_TRUCKER]
(
	@EndPICYrWeek		varchar(8000)
	,@StartPICYrWeek	varchar(8000)
   
)
AS
BEGIN

	SELECT '%' as Trucker, '--All--' as Trucker1
	UNION ALL
	SELECT DISTINCT
	
	Replace(Rtrim(MD.TruckerName),',','') as Trucker,
	--Rtrim(MD.TruckerName) as Trucker,
	Rtrim(MD.TruckerName) as Trucker1
	
	From  dbo.cft_MARKET_LOAD MD
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo DD
	on MD.MovementDate = DD.DayDate
	
	Where DD.PICYear_Week >= @StartPICYrWeek and DD.PICYear_Week <= @EndPICYrWeek 
	
	Order by
	Trucker
		
		
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_DRIVER_LOAD_INFORMATION_TRUCKER] TO [db_sp_exec]
    AS [dbo];

