 CREATE Procedure IRDemandCalc_Results
	@InvtID VarChar(30),
	@SiteID VarChar(10),
	@CurrentPeriod VarChar(6),
	@NbrDaysInPeriod Int,
	@S4Future03 Float = NULL
As
-- This proc is a helper proc, so Solomon can read the results of the IRDemandCalc procedure.  Solomon does not appear to handle output variables.
-- The usage returned would be for the period BEFORE the one passed in, the monthly total and the UsageperPeriod are for the current month.
-- VM, 09/12/01, the following commented out, because fiscal period days passed as a parameter
-- Declare @ReturnNbrDaysInPeriod Int
Declare @ReturnUsagePerDay Float
Declare @ReturnUsagePerPeriod Float

-- VM, 8/14/01, IRDemandCalc renamed to IRDemCalc

Exec IRDemCalc @InvtID, @SiteID, @CurrentPeriod, @NbrDaysInPeriod, @ReturnUsagePerDay OUTPUT,@ReturnUsagePerPeriod OUTPUT,@S4Future03

Select
	@ReturnUsagePerDay 'UsageDaily',
	@ReturnUsagePerPeriod 'UsagePeriod'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRDemandCalc_Results] TO [MSDSL]
    AS [dbo];

