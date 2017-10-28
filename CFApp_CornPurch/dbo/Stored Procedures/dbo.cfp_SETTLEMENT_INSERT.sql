
-- ===================================================================
-- Author:	Sergey Neskin
-- Create date: 09/08/2008
-- Description:	Inserts a record into cft_SETTLEMENT table
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_SETTLEMENT_INSERT]
(
	@SettlementID int out,	
	@PartialTicketID int,
	@TicketNumber varchar(20),
	@PayTo_VendorID varchar(15),
	@Delivery_VendorID varchar(15),
	@ContractNumber varchar(72),
	@ActualPricePerBushel decimal(18,4),
	@CashPricePerBushel  decimal(18,4),
	@ContractAdjustmentAmount decimal(18,4),
	@MoistureValuationMethodScheduleID int,
	@MoistureDeductionAmount decimal(18,4),
	@MoistureScheduleID int,
	@DryingChargesAmount decimal(18,4),
	@DryingChargesScheduleID int,
	@ShrinkScheduleID int,
	@TestWeightAmount decimal(18,4),
	@TestWeightScheduleID int,
	@ForeignMaterialAmount decimal(18,4),
	@ForeignMaterialScheduleID int,
	@CornCheckoffAmount decimal(18,4),
	@EthanolCheckoffAmount decimal(18,4),
	@HandlingAmount decimal(18,4),
	@HandlingScheduleID int,
	@DeferredPaymentAmount decimal(18,4),
	@DeferredPaymentScheduleID int,
	@DelayedCornPricingVarianceAmount decimal(18,4),
	@PurchaseCornOptionsAmount  decimal(18,4),
	@MiscellaneousAdjustmentAmount decimal(18,4),
	@FSAPaymentAmt decimal(18,4),
	@CheckNumber varchar(10),
	@APBatchNumber varchar(10),
	@MoistureMethod int,
	@CornClearingAmount decimal(18,4),
	@MarketVariance decimal(18,4),
	@AccountsPayableBatchType int,
	@FSALoanNumber varchar(100),  
	@HandlingStartDate smalldatetime,
	@DeferredStartDate smalldatetime,
	@NetPaymentPerBushel decimal (18,4)
)
AS BEGIN
SET NOCOUNT ON;

INSERT INTO dbo.cft_SETTLEMENT
(
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
)
VALUES
(
	@PartialTicketID,	
	@TicketNumber,
	@PayTo_VendorID,
	@Delivery_VendorID,
	@ContractNumber,
	@ActualPricePerBushel,
	@CashPricePerBushel,
	@ContractAdjustmentAmount,
	@MoistureValuationMethodScheduleID,
	@MoistureDeductionAmount,
	@MoistureScheduleID,
	@DryingChargesAmount,
	@DryingChargesScheduleID,
	@ShrinkScheduleID,
	@TestWeightAmount,
	@TestWeightScheduleID,
	@ForeignMaterialAmount,
	@ForeignMaterialScheduleID,
	@CornCheckoffAmount,
	@EthanolCheckoffAmount,
	@HandlingAmount,
	@HandlingScheduleID,
	@DeferredPaymentAmount,
	@DeferredPaymentScheduleID,
	@DelayedCornPricingVarianceAmount,
	@PurchaseCornOptionsAmount,
	@MiscellaneousAdjustmentAmount,
	@FSAPaymentAmt,
	@CheckNumber,
	@APBatchNumber,
	@MoistureMethod,
	@CornClearingAmount,
	@MarketVariance,
	@AccountsPayableBatchType,
	@FSALoanNumber,
	@HandlingStartDate,
	@DeferredStartDate,
	@NetPaymentPerBushel
)

SET @SettlementID = SCOPE_IDENTITY()
RETURN @SettlementID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SETTLEMENT_INSERT] TO [db_sp_exec]
    AS [dbo];

