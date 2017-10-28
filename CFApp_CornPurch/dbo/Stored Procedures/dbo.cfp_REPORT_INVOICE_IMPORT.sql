-- =============================================
-- Author:		Matt Dawson
-- Create date: 09/11/2008
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_INVOICE_IMPORT]
(	
	@APBatchNumber VARCHAR(10)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT	cft_SETTLEMENT.APBatchNumber
,	cft_FEED_MILL.Name 'FeedMillName'
,	cft_SETTLEMENT.TicketNumber
,	cft_SETTLEMENT.PayTo_VendorID
,	cft_SETTLEMENT.Delivery_VendorID
,	CASE WHEN (cft_SETTLEMENT.FSAPaymentAmt > 0) 
		THEN COALESCE(cft_Contract.PayToCornProducerID,cft_SETTLEMENT.Delivery_VendorID)
		ELSE ''
	END 'PayRemainderTo'
,	Vendor.Name 'CornProducerName'
,	CASE cft_SETTLEMENT.AccountsPayableBatchType
		WHEN 1 THEN 'ACH'
		WHEN 2 THEN 'Check'
		ELSE 'N/A'
	END 'PaymentType'
,	cast(COALESCE(cft_SETTLEMENT.FSAPaymentAmt,0) as numeric(14,2)) 'FSAPaymentAmt'
,	COALESCE(DryBushels.SUMDryBushels,0) 'DryBushels'
,	COALESCE(cft_SETTLEMENT.ActualPricePerBushel,0) 'ActualPricePerBushel'
,	case when (DryBushels.SentTOInventory = 1)
		then cast((COALESCE(DryBushels.SUMDryBushels,0) * COALESCE(cft_INVENTORY_BATCH.ValuePrice,0)) as numeric(14,2)) 
		+ cast((COALESCE(DryBushels.SUMDryBushels,0)
		* (COALESCE(cft_SETTLEMENT.ActualPricePerBushel,0) - COALESCE(cft_INVENTORY_BATCH.ValuePrice,0))) as numeric(14,2)) 
		else cast((COALESCE(DryBushels.SUMDryBushels,0) * COALESCE(cft_SETTLEMENT.ActualPricePerBushel,0)) as numeric(14,2)) 
	end 'CornClearing'
,	COALESCE(cft_SETTLEMENT.CornCheckoffAmount,0) 'CornCheckoffAmount'
,	COALESCE(cft_SETTLEMENT.EthanolCheckoffAmount,0) 'EthanolCheckoffAmount'
,	COALESCE(cft_SETTLEMENT.DryingChargesAmount,0) 'DryingChargesAmount'
,	COALESCE(cft_SETTLEMENT.MoistureDeductionAmount,0) 'MoistureDeductionAmount'
,	COALESCE(cft_SETTLEMENT.DelayedCornPricingVarianceAmount,0) 'DelayedCornPricingVarianceAmount'
,	COALESCE(cft_SETTLEMENT.HandlingAmount,0) 'HandlingAmount'
,	COALESCE(cft_SETTLEMENT.ForeignMaterialAmount,0) 'ForeignMaterialAmount'
,	COALESCE(cft_SETTLEMENT.TestWeightAmount,0) 'TestWeightAmount'
,	COALESCE(cft_SETTLEMENT.MiscellaneousAdjustmentAmount,0) 'MiscellaneousAdjustmentAmount'
,	COALESCE(cft_SETTLEMENT.PurchaseCornOptionsAmount,0) 'PurchaseCornOptionsAmount'
,	COALESCE(cft_SETTLEMENT.DeferredPaymentAmount,0) 'DeferredPaymentAmount'
,	COALESCE(cft_SETTLEMENT.ContractAdjustmentAmount,0) 'ContractAdjustmentAmount'

--total calculated from gemini #821
--,	CAST((CAST(COALESCE(DryBushels.SUMDryBushels,0) AS numeric(14,4)) * cast(COALESCE(cft_SETTLEMENT.ActualPricePerBushel,0) as numeric(14,4)))
,	cast(case when (DryBushels.SentTOInventory = 1)
		then cast((COALESCE(DryBushels.SUMDryBushels,0) * COALESCE(cft_INVENTORY_BATCH.ValuePrice,0)) as numeric(14,2))
		+ cast(COALESCE(DryBushels.SUMDryBushels,0) 
		* (COALESCE(cft_SETTLEMENT.ActualPricePerBushel,0) - COALESCE(cft_INVENTORY_BATCH.ValuePrice,0)) as numeric(14,2))
		else cast(COALESCE(DryBushels.SUMDryBushels,0) * COALESCE(cft_SETTLEMENT.ActualPricePerBushel,0) as numeric(14,2))
	end
-	(cast(COALESCE(cft_SETTLEMENT.CornCheckoffAmount,0) as numeric(14,2))
+	ABS(cast(COALESCE(cft_SETTLEMENT.ForeignMaterialAmount,0) as numeric(14,2)))
+	ABS(cast(COALESCE(cft_SETTLEMENT.TestWeightAmount,0) as numeric(14,2)))
+	ABS(cast(COALESCE(cft_SETTLEMENT.MoistureDeductionAmount,0) as numeric(14,2)))
+	cast(COALESCE(cft_SETTLEMENT.MiscellaneousAdjustmentAmount,0) as numeric(14,2))
-	cast(COALESCE(cft_SETTLEMENT.DeferredPaymentAmount,0) as numeric(14,2))
+	ABS(cast(COALESCE(cft_SETTLEMENT.HandlingAmount,0) as numeric(14,2)))
+	cast(COALESCE(cft_SETTLEMENT.EthanolCheckoffAmount,0) as numeric(14,2))
+	ABS(cast(COALESCE(cft_SETTLEMENT.DryingChargesAmount,0) as numeric(14,2)))
-	cast(COALESCE(cft_SETTLEMENT.ContractAdjustmentAmount,0) as numeric(14,2))
-	cast(COALESCE(cft_SETTLEMENT.PurchaseCornOptionsAmount,0) as numeric(14,2))) AS NUMERIC(14,2)) 'Total'

FROM		dbo.cft_SETTLEMENT cft_SETTLEMENT (NOLOCK)
LEFT OUTER JOIN	dbo.cft_CORN_PRODUCER cft_CORN_PRODUCER (NOLOCK)
	ON cft_CORN_PRODUCER.CornProducerID = cft_SETTLEMENT.PayTo_VendorID
LEFT OUTER JOIN dbo.cft_Vendor Vendor (NOLOCK)
	ON RTRIM(Vendor.VendID) = RTRIM(cft_CORN_PRODUCER.CornProducerID)
LEFT OUTER JOIN (SELECT pt.PartialTicketID, pt.TicketNumber, pt.CornProducerID, pt.SentToInventory, COALESCE(c.ContractNumber,'') 'ContractNumber', SUM(DryBushels) 'SUMDryBushels' 
	FROM dbo.cft_PARTIAL_TICKET pt (NOLOCK) 
	LEFT OUTER JOIN dbo.cft_Contract c (NOLOCK)
		ON c.ContractID = pt.ContractID
	GROUP BY pt.PartialTicketID, pt.TicketNumber, pt.CornProducerID, pt.SentToInventory, c.ContractNumber) DryBushels
		ON DryBushels.PartialTicketID = cft_SETTLEMENT.PartialTicketID
LEFT OUTER JOIN dbo.cft_INVENTORY_BATCH cft_INVENTORY_BATCH (NOLOCK)
	ON cft_SETTLEMENT.PartialTicketID = cft_INVENTORY_BATCH.PartialTicketID
LEFT OUTER JOIN dbo.cft_CORN_TICKET cft_CORN_TICKET (NOLOCK)
	ON RTRIM(cft_CORN_TICKET.TicketNumber) = RTRIM(cft_SETTLEMENT.TicketNumber)
LEFT OUTER JOIN dbo.cft_FEED_MILL cft_FEED_MILL (NOLOCK)
	ON cft_FEED_MILL.FeedMillID = cft_CORN_TICKET.FeedMillID
----LEFT OUTER JOIN (SELECT APBatchNumber, CASE WHEN (COALESCE(SUM(FSAPaymentAmt),0) > 0) THEN 1 ELSE 0 END 'FSAPaymentChk' FROM dbo.cft_SETTLEMENT (NOLOCK) WHERE RTRIM(APBatchNumber) = RTRIM(@APBatchNumber) GROUP BY APBatchNumber) FSAPmtChk
----	ON FSAPmtChk.APBatchNumber = cft_SETTLEMENT.APBatchNumber
LEFT OUTER JOIN dbo.cft_Contract cft_Contract (NOLOCK)
	ON RTRIM(cft_Contract.ContractNumber) = RTRIM(cft_Settlement.ContractNumber)
WHERE RTRIM(cft_SETTLEMENT.APBatchNumber) = RTRIM(@APBatchNumber)
ORDER BY
	cft_SETTLEMENT.TicketNumber
,	cft_SETTLEMENT.PayTo_VendorID
,	cft_SETTLEMENT.Delivery_VendorID



END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_INVOICE_IMPORT] TO [db_sp_exec]
    AS [dbo];

