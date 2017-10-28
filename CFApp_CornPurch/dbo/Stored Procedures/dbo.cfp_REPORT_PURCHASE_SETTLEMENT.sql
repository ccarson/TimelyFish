



-- =============================================
-- Author:		Matt Dawson
-- Create date: 09/16/2008
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_PURCHASE_SETTLEMENT]
	@CornProducerID varchar(15)
,	@MasterSettlementID varchar(100)
,	@APBatchNumber varchar(10)
,	@StartDate datetime = NULL
,	@EndDate datetime = NULL
AS
BEGIN


CREATE TABLE #MASTER_SETTLEMENT 
(	MasterSettlementID varchar(100),
	APBatchNumber varchar(10),
	Delivery_VendorID varchar(15),
	PayTo_VendorID varchar(15))

INSERT INTO #MASTER_SETTLEMENT
SELECT * FROM dbo.cft_Master_settlement (NOLOCK)
WHERE RTRIM(APBatchNumber) LIKE ISNULL(@APBatchNumber,'%')
AND	RTRIM(Delivery_VendorID) LIKE @CornProducerID
AND MasterSettlementID LIKE @MasterSettlementID

CREATE TABLE #REPORT_DATA
(	MasterSettlementID varchar(100)
,	APBatchNumber varchar(10)
,	SettlementID int
,	FeedMillID char(10)
,	FeedMillName varchar(50)
,	FeedMillAddress1 varchar(30)
,	FeedMillAddress2 varchar(30)
,	FeedMillCity varchar(30)
,	FeedMillState varchar(2)
,	FeedMillZip varchar(10)
,	GrainDealerLicenseNumber varchar(50)
,	CornProducer char(30)
,	PayToVendorID varchar(15)
,	PayToVendor char(30)
,	PayToVendorAddress1 char(30)
,	PayToVendorAddress2 char(30)
,	PayToVendorCity char(30)
,	PayToVendorState char(3)
,	PayToVendorZip char(10)
,	DeliveryVendorID varchar(15)
,	DeliveryVendorName char(30)
,	FSALoanNumber varchar(100)
,	Commodity varchar(20)
,	DeliveryDate datetime
,	FullTicketNumber varchar(20)
,	PartialTicketNumber varchar(20)
,	SumWetBushels decimal(20,4)
,	DryBushels decimal(18,4)
,	PaymentType varchar(50)
,	ActualPricePerBushel decimal(18,4)
,	ContractNumber varchar(72)
,	Premium_Deduct money
,	MiscellaneousAdjustmentAmount decimal(18,4)
,	Moisture decimal(18,4)
,	DryingCharge decimal(18,4)
,	TestWeight decimal(18,4)
,	TestWeightCharge decimal(18,4)
,	ForeignMaterial decimal(18,4)
,	ForeignMaterialCharge decimal(18,4)
,	CornCheckoff decimal(18,4)
,	EthanolCheckoff decimal(18,4)
,	HandlingStartDate datetime
,	HandlingCharge decimal(18,4)
,	DeferredPremiumStartDate datetime
,	DeferredPaymentAmount decimal(18,4)
,	FSAPaymentAmt decimal(18,4)
,	PayRemainderTo varchar(15)
,	MoistureDeductionAmount decimal(18,4)
,	PurchaseCornOptionsAmount decimal(18,4)
,	ContractAdjustmentAmount decimal(18,4)
,	Total decimal(18,2)
,   comments varchar(9)
,   paymentdate datetime)	-- 20130628 as per amy's request


	INSERT INTO #REPORT_DATA
	SELECT
		cft_Master_Settlement.MasterSettlementID
	,	cfv_SETTLEMENT.APBatchNumber
	,	cfv_SETTLEMENT.SettlementID
	,	cft_Corn_Ticket.FeedMillID
	,	cft_Feed_Mill.Name 'FeedMillName'
	,	cft_Feed_Mill.Address1 'FeedMillAddress1'
	,	cft_Feed_Mill.Address2 'FeedMillAddress2'
	,	cft_Feed_Mill.City 'FeedMillCity'
	,	cft_Feed_Mill.State 'FeedMillState'
	,	cft_Feed_Mill.Zip 'FeedMillZip'
	,	cft_Feed_Mill.GrainDealerLicenseNumber
	,	V.RemitName 'CornProducer'
	,	RTRIM(cfv_SETTLEMENT.PayTo_VendorID) 'PayToVendorID'
	,	Vendor.Name 'PayToVendor'
	,	Vendor.Addr1 'PayToVendorAddress1'
	,	Vendor.Addr2 'PayToVendorAddress2'
	,	Vendor.City 'PayToVendorCity'
	,	Vendor.State 'PayToVendorState'
	,	Vendor.Zip 'PayToVendorZip'
	,	cfv_SETTLEMENT.Delivery_VendorID 'DeliveryVendorID'
	,	cfv_SETTLEMENT.Delivery_VendorName 'DeliveryVendorName'
	,	cfv_SETTLEMENT.FSALoanNumber
	,	cft_Corn_Ticket.Commodity
	,	CONVERT(VARCHAR, cft_Corn_Ticket.DeliveryDate, 101) 'DeliveryDate'
	,	cft_Corn_Ticket.TicketNumber 'FullTicketNumber'
	,	cft_Partial_Ticket.TicketNumber 'PartialTicketNumber'
	,	(COALESCE(cft_Partial_Ticket.WetBushels,0)) 'SumwetBushels'
	,	(COALESCE(cft_Partial_Ticket.DryBushels,0)) 'DryBushels'
	,	COALESCE(cft_TICKET_PAYMENT_TYPE.Name, 'N/A') 'PaymentType'
	,	cfv_SETTLEMENT.ActualPricePerBushel
	,	cft_Contract.ContractNumber
	,	COALESCE(cft_Contract.Premium_Deduct,0) 'Premium_Deduct'
	,	COALESCE(cfv_SETTLEMENT.MiscellaneousAdjustmentAmount,0) 'MiscellaneousAdjustmentAmount'
	,	COALESCE(cft_Corn_Ticket.Moisture,0) 'Moisture'
	,	COALESCE(cfv_SETTLEMENT.DryingChargesAmount,0) 'DryingCharge'
	,	cft_Corn_Ticket.TestWeight
	,	COALESCE(cfv_SETTLEMENT.TestWeightAmount,0) 'TestWeightCharge'
	,	cft_Corn_Ticket.ForeignMaterial
	,	COALESCE(cfv_SETTLEMENT.ForeignMaterialAmount,0) 'ForeignMaterialCharge'
	,	COALESCE(cfv_SETTLEMENT.CornCheckoffAmount,0) 'CornCheckoff'
	,	COALESCE(cfv_SETTLEMENT.EthanolCheckoffAmount,0) 'EthanolCheckoff'
	,	CONVERT(VARCHAR, cfv_SETTLEMENT.HandlingStartDate, 101) 'HandlingStartDate'
	,	COALESCE(cfv_SETTLEMENT.HandlingAmount,0) 'HandlingCharge'
	,	CONVERT(VARCHAR, cfv_SETTLEMENT.DeferredStartDate, 101) 'DeferredPremiumStartDate'
	,	COALESCE(cfv_SETTLEMENT.DeferredPaymentAmount,0) 'DeferredPaymentAmount'
	,	COALESCE(cfv_SETTLEMENT.FSAPaymentAmt,0) 'FSAPaymentAmt'
	,	CASE WHEN (COALESCE(cfv_SETTLEMENT.FSAPaymentAmt,0) > 0) 
			THEN COALESCE(cft_Contract.PayToCornProducerID,cfv_SETTLEMENT.Delivery_VendorID)
			ELSE ''
		END 'PayRemainderTo'
	,	COALESCE(cfv_SETTLEMENT.MoistureDeductionAmount,0) 'MoistureDeductionAmount'
	,	COALESCE(cfv_SETTLEMENT.PurchaseCornOptionsAmount,0) 'PurchaseCornOptionsAmount'
	,	COALESCE(cfv_SETTLEMENT.ContractAdjustmentAmount,0) 'ContractAdjustmentAmount'

	--total calculated from gemini #821
	,	cast(case when (cft_Partial_Ticket.SentTOInventory = 1)
			then cast((COALESCE((cft_Partial_Ticket.DryBushels),0) * COALESCE(cft_INVENTORY_BATCH.ValuePrice,0)) as numeric(14,2))
			+ cast(COALESCE((cft_Partial_Ticket.DryBushels),0) 
			* (COALESCE(cfv_SETTLEMENT.ActualPricePerBushel,0) - COALESCE(cft_INVENTORY_BATCH.ValuePrice,0)) as numeric(14,2))
			else cast(COALESCE((cft_Partial_Ticket.DryBushels),0) * COALESCE(cfv_SETTLEMENT.ActualPricePerBushel,0) as numeric(14,2))
		end

	-	(cast(COALESCE(cfv_SETTLEMENT.CornCheckoffAmount,0) as numeric(14,2))
	+	ABS(cast(COALESCE(cfv_SETTLEMENT.ForeignMaterialAmount,0) as numeric(14,2)))
	+	ABS(cast(COALESCE(cfv_SETTLEMENT.TestWeightAmount,0) as numeric(14,2)))
	+	ABS(cast(COALESCE(cfv_SETTLEMENT.MoistureDeductionAmount,0) as numeric(14,2)))
	+	cast(COALESCE(cfv_SETTLEMENT.MiscellaneousAdjustmentAmount,0) as numeric(14,2))
	-	cast(COALESCE(cfv_SETTLEMENT.DeferredPaymentAmount,0) as numeric(14,2))
	+	ABS(cast(COALESCE(cfv_SETTLEMENT.HandlingAmount,0) as numeric(14,2)))
	+	cast(COALESCE(cfv_SETTLEMENT.EthanolCheckoffAmount,0) as numeric(14,2))
	+	ABS(cast(COALESCE(cfv_SETTLEMENT.DryingChargesAmount,0) as numeric(14,2)))
	-	cast(COALESCE(cfv_SETTLEMENT.ContractAdjustmentAmount,0) as numeric(14,2))
	-	cast(COALESCE(cfv_SETTLEMENT.PurchaseCornOptionsAmount,0) as numeric(14,2))) AS NUMERIC(14,2)) 'Total'
	, substring(cft_Corn_Ticket.comments,1,9) as comments		-- 20130424 as per Amy's request
	, cfv_settlement.paymentdate	-- 20130628 as per amy's request


	FROM #MASTER_SETTLEMENT cft_Master_Settlement
	JOIN dbo.cfv_Settlement cfv_SETTLEMENT (NOLOCK)
		ON	(RTRIM(cft_MASTER_SETTLEMENT.APBatchNumber) = RTRIM(cfv_SETTLEMENT.APBatchNumber)
		AND	RTRIM(cft_MASTER_SETTLEMENT.Delivery_VendorID) = RTRIM(cfv_SETTLEMENT.Delivery_VendorID)
		AND	RTRIM(cft_MASTER_SETTLEMENT.PayTo_VendorID) = RTRIM(cfv_SETTLEMENT.PayTo_VendorID))

	LEFT OUTER JOIN dbo.cft_Partial_Ticket cft_Partial_Ticket (NOLOCK)
		ON	RTRIM(cfv_SETTLEMENT.PartialTicketID) = RTRIM(cft_Partial_Ticket.PartialTicketID)
	LEFT OUTER JOIN dbo.cft_Corn_Ticket cft_Corn_Ticket (NOLOCK)
		ON	cft_Partial_Ticket.FullTicketID = cft_Corn_Ticket.TicketID
	LEFT OUTER JOIN dbo.cft_INVENTORY_BATCH cft_INVENTORY_BATCH (NOLOCK)
		ON	cft_INVENTORY_BATCH.PartialTicketID = cft_Partial_Ticket.PartialTicketID
	LEFT OUTER JOIN dbo.cft_Corn_Producer cft_Corn_Producer (NOLOCK)
		ON	cft_Corn_Producer.CornProducerID = ISNULL(cft_Partial_Ticket.DeliveryCornProducerID,cft_Partial_Ticket.CornProducerID)
	LEFT OUTER JOIN dbo.cft_Vendor V (NOLOCK) 
		ON V.VendId = cft_Corn_Producer.CornProducerID
	LEFT OUTER JOIN dbo.cft_Vendor Vendor (NOLOCK)
		ON	RTRIM(Vendor.VendID) = RTRIM(cfv_SETTLEMENT.PayTo_VendorID)
	LEFT OUTER JOIN dbo.cft_Contract cft_Contract (NOLOCK)
		ON cft_Contract.ContractID = cft_Partial_Ticket.ContractID
	LEFT OUTER JOIN dbo.cft_Feed_Mill cft_Feed_Mill (NOLOCK)
		ON RTRIM(cft_Feed_Mill.FeedMillID) = RTRIM(cft_Corn_Ticket.FeedMillID)
	LEFT OUTER JOIN dbo.cft_TICKET_PAYMENT_TYPE cft_TICKET_PAYMENT_TYPE (NOLOCK)
		ON cft_TICKET_PAYMENT_TYPE.PaymentTypeID = cft_Partial_Ticket.PaymentTypeID
	WHERE convert(varchar,cfv_SETTLEMENT.PaymentDate,101) between isnull(@StartDate,'1/1/1900') and isnull(@EndDate,'1/1/3000')

SELECT * FROM #REPORT_DATA
ORDER BY DeliveryDate, FullTicketNumber, PartialTicketNumber

drop table #MASTER_SETTLEMENT
drop table #REPORT_DATA
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_PURCHASE_SETTLEMENT] TO [db_sp_exec]
    AS [dbo];

