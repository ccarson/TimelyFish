

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 12/28/2010
-- Description:	Returns R&M P&L Purchase Order Number
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPAIRS_DRILLDOWN_PURCHASEORDERNUMBER]
(
	
	 @StartPeriod			int
	,@EndPeriod				int
   
)
AS
BEGIN
	
	Select '%' as PurchaseOrderNumber1,
	'--All--' as PurchaseOrderNumber
	Union
	Select Distinct
	RC.PurchaseOrderNumber as PurchaseOrderNumber1,
	RC.PurchaseOrderNumber
	From  dbo.cft_REPAIRS_PROBLEM_ID_COST RC

	Where RC.GroupPeriod between @StartPeriod and @EndPeriod
		
	Order by
	RC.PurchaseOrderNumber
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPAIRS_DRILLDOWN_PURCHASEORDERNUMBER] TO [db_sp_exec]
    AS [dbo];

