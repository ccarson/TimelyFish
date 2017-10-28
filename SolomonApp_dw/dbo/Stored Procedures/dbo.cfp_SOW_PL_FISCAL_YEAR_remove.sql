

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 12/14/2010
-- Description:	Returns Sow P&L Fiscal Years
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_PL_FISCAL_YEAR_remove]
(
	
	 @StartPeriod2		int
	,@EndPeriod			int

)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Select
	
	PL.MinFiscalYear,
	(PL.MaxFiscalYear + PL.MinFiscalYear)/2 as MidFiscalYear,
	PL.MaxFiscalYear

	From (Select Distinct
	
	Cast(Min(left(rtrim(GroupPeriod),4)) as integer) as MinFiscalYear,
	Cast(Max(left(rtrim(GroupPeriod),4)) as integer) as MaxFiscalYear
	
	From  dbo.cft_SOW_PL 
	
	Where GroupPeriod between @StartPeriod2 and @EndPeriod) PL
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_PL_FISCAL_YEAR_remove] TO [db_sp_exec]
    AS [dbo];

