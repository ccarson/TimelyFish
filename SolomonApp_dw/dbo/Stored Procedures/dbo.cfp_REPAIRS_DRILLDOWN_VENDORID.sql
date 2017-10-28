

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 12/28/2010
-- Description:	Returns R&M P&L Vendor ID
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPAIRS_DRILLDOWN_VENDORID]
(
	
	 @StartPeriod			int
	,@EndPeriod				int
   
)
AS
BEGIN
	
	Select '%' as VendorID1,
	'--All--' as VendorID
	Union
	Select Distinct
	RC.VendorID as VendorID1,
	RC.VendorID
	From  dbo.cft_REPAIRS_PROBLEM_ID_COST RC

	Where RC.GroupPeriod between @StartPeriod and @EndPeriod
		
	Order by
	RC.VendorID
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPAIRS_DRILLDOWN_VENDORID] TO [db_sp_exec]
    AS [dbo];

