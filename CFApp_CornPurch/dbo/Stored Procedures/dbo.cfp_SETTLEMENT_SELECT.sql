
-- ===================================================================
-- Author:	Sergey Neskin
-- Create date: 09/08/2008
-- Description:	Select a record from cft_SETTLEMENT table
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_SETTLEMENT_SELECT]
(
	@SettlementID int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT SettlementID,
	PartialTicketID,
	TicketNumber,
	PayTo_VendorID,
	Delivery_VendorID,
	ContractNumber,
	ActualPricePerBushel,
	CashPricePerBushel,
	ContractAdjustmentAmount,
	MoistureValuationMethodScheduleID,
	MoistureDeductionAmount,
	MoistureScheduleID,
	DryingChargesAmount,
	DryingChargesScheduleID,
	ShrinkScheduleID,
	TestWeightAmount,
	TestWeightScheduleID,
	ForeignMaterialAmount,
	ForeignMaterialScheduleID,
	CornCheckoffAmount,
	EthanolCheckoffAmount,
	HandlingAmount,
	HandlingScheduleID,
	DeferredPaymentAmount,
	DeferredPaymentScheduleID,
	DelayedCornPricingVarianceAmount,
	PurchaseCornOptionsAmount,
	MiscellaneousAdjustmentAmount,
	FSAPaymentAmt,
	CheckNumber,
	APBatchNumber,
	MoistureMethod,
	CornClearingAmount,
	MarketVariance,
	AccountsPayableBatchType,
	FSALoanNumber,
	HandlingStartDate,
	DeferredStartDate,
	NetPaymentPerBushel
FROM dbo.cft_SETTLEMENT
WHERE SettlementID = @SettlementID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SETTLEMENT_SELECT] TO [db_sp_exec]
    AS [dbo];

