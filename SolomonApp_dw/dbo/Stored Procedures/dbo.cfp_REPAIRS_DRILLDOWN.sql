

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 12/28/2010
-- Description:	Returns R&M P&L Values
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPAIRS_DRILLDOWN]
(
	
	 @StartPeriod			int
	,@EndPeriod				int
	,@RollupDescription		nvarchar(30)
	,@Description			nvarchar(30)
	,@FaultDescription		nvarchar(30)
	,@VendorID				nvarchar(30)
	,@PurchaseOrderNumber	nvarchar(30)

   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @TempRollupDescription varchar(20)

	IF @RollupDescription = '%' 

	BEGIN
		SET @TempRollupDescription = '%'
	END
	
	ELSE
	BEGIN
		SET @TempRollupDescription = @RollupDescription
	END
	
	DECLARE @TempDescription varchar(20)

	IF @Description = '%' 

	BEGIN
		SET @TempDescription = '%'
	END
	
	ELSE
	BEGIN
		SET @TempDescription = @Description
	END
	
	DECLARE @TempFaultDescription varchar(20)

	IF @FaultDescription = '%' 

	BEGIN
		SET @TempFaultDescription = '%'
	END
	
	ELSE
	BEGIN
		SET @TempFaultDescription = @FaultDescription
	END
	
	DECLARE @TempVendorID varchar(20)

	IF @VendorID = '%' 

	BEGIN
		SET @TempVendorID = '%'
	END
	
	ELSE
	BEGIN
		SET @TempVendorID = @VendorID
	END
	
	DECLARE @TempPurchaseOrderNumber varchar(20)

	IF @PurchaseOrderNumber = '%' 

	BEGIN
		SET @TempPurchaseOrderNumber = '%'
	END
	
	ELSE
	BEGIN
		SET @TempPurchaseOrderNumber = @PurchaseOrderNumber
	END

	Select 
	RC.Account,
	RC.Division,
	RC.Location,
	RC.Capacity,
	RC.GroupPeriod,
	RC.RollupDescription,
	RC.Description,
	RC.TransactionDescription,
	RC.FaultDescription,
	RC.PurchaseOrderNumber,
	RC.VendorID,
	RC.Amount,
	Case when RC.Capacity = 0 then 0 else ((Sum(RC.Amount)/RC.Capacity)/
	(Select Count(WeekofDate) Weeks From [$(SolomonApp)].dbo.cftWeekDefinition
	where Case When FiscalPeriod < 10 
	Then Rtrim(Cast(FiscalYear as char))+'0'+Rtrim(Cast(FiscalPeriod as char)) 
	else Rtrim(Cast(FiscalYear as char))+Rtrim(Cast(FiscalPeriod as char)) end between @StartPeriod and @EndPeriod))
	*52 end as 'AmtSpc'
	From  dbo.cft_REPAIRS_PROBLEM_ID_COST RC

	Where RC.GroupPeriod between @StartPeriod and @EndPeriod
	and RC.RollupDescription like @TempRollupDescription
	and RC.Description like @TempDescription
	and RC.FaultDescription like @TempFaultDescription
	and RC.VendorID like @TempVendorID
	and RC.PurchaseOrderNumber like @TempPurchaseOrderNumber
	
	Group by
	RC.Account,
	RC.Division,
	RC.Location,
	RC.Capacity,
	RC.GroupPeriod,
	RC.RollupDescription,
	RC.Description,
	RC.TransactionDescription,
	RC.FaultDescription,
	RC.PurchaseOrderNumber,
	RC.VendorID,
	RC.Amount
		
	Order by
	RC.Division,
	RC.Location,
	RC.Groupperiod,
	RC.Description,
	RC.TransactionDescription,
	RC.FaultDescription,
	RC.PurchaseOrderNumber,
	RC.VendorID
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPAIRS_DRILLDOWN] TO [db_sp_exec]
    AS [dbo];

