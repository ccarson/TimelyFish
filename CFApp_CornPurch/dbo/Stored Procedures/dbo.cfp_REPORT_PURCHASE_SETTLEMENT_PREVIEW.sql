
-- =============================================================================
-- Author:		Nick Honetschlager
-- Create date: 3/13/2015
-- Description:	Generates data for Preview of Payment Report in Corn Purchasing.
-- =============================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_PURCHASE_SETTLEMENT_PREVIEW]

	@CornProducerID varchar(15)
,	@StartDate datetime = NULL
,	@EndDate datetime = NULL
,	@CornPrice as decimal(18,4) = NULL
,	@TotalRequestedBushels as int = NULL
,	@TotalRequestedPaid as decimal(18,2) = NULL
AS
BEGIN

CREATE TABLE #TEMP_SETTLEMENT
(   SettlementID int IDENTITY(1,1),	
	PartialTicketID int null,
	TicketNumber varchar(20) null,
	PayTo_VendorID varchar(15) null,
	Delivery_VendorID varchar(15) null,
	ContractNumber varchar(72) null,
	ActualPricePerBushel decimal(18,4) null,
	CashPricePerBushel  decimal(18,4) null,
	ContractAdjustmentAmount decimal(18,4) null,
	MoistureValuationMethodScheduleID int null,
	MoistureDiscount decimal(18,4) null,
	MoistureDeductionAmount decimal(18,4) null,
	MoistureScheduleID int null,
	DryingChargesAmount decimal(18,4) null,
	DryingChargesScheduleID int null,
	ShrinkDiscount decimal(18,4) null,
	ShrinkScheduleID int null,
	TestWeightAmount decimal(18,4) null,
	TestWeightScheduleID int null,
	ForeignMaterialAmount decimal(18,4) null,
	ForeignMaterialScheduleID int null,
	CornCheckoffAmount decimal(18,4) null,
	EthanolCheckoffAmount decimal(18,4) null,
	HandlingAmount decimal(18,4) null,
	HandlingScheduleID int null,
	DeferredPaymentAmount decimal(18,4) null,
	DeferredPaymentScheduleID int null,
	DelayedCornPricingVarianceAmount decimal(18,4) null,
	PurchaseCornOptionsAmount  decimal(18,4) null,
	MiscellaneousAdjustmentAmount decimal(18,4) null,
	FSAPaymentAmt decimal(18,4) null,
	CheckNumber varchar(10) null,
	APBatchNumber varchar(10) null,
	MoistureMethod int null,
	CornClearingAmount decimal(18,4) null,
	MarketVariance decimal(18,4) null,
	AccountsPayableBatchType int null,
	FSALoanNumber varchar(100) null,  
	HandlingStartDate smalldatetime null,
	DeferredStartDate smalldatetime null,
	NetPaymentPerBushel decimal (18,4) null

)

INSERT INTO  #TEMP_SETTLEMENT
SELECT pt.PartialTicketID
     , pt.TicketNumber
     , CASE WHEN (cn.PayToCornProducerID IS NULL OR cn.PayToCornProducerID = '')
		THEN pt.CornProducerID ELSE cn.PayToCornProducerID
		END AS 'PayTo_VendorID'
	, pt.CornProducerID AS 'Delivery_VendorID'
	 , cn.ContractNumber
	 , CASE WHEN @CornPrice IS NOT NULL Then @CornPrice
		WHEN pt.PaymentTypeID = 2 AND cn.ContractNumber IS NOT NULL AND cn.Futures IS NOT NULL AND cn.PricedBasis IS NOT NULL THEN (cn.Futures + cn.PricedBasis)
	    WHEN qt.QuoteID IS NOT NULL THEN qt.Price  
	    WHEN dpd.DailyPriceDetailID IS NOT NULL THEN dpd.Price
	    END 	 AS 'ActualPricePerBushel'
	 , CASE WHEN pt.PaymentTypeID = 2 AND cn.ContractNumber IS NOT NULL AND cn.Futures IS NOT NULL AND cn.PricedBasis IS NOT NULL THEN (cn.Futures + cn.PricedBasis)
	    WHEN qt.QuoteID IS NOT NULL THEN qt.Price  
	    WHEN dpd.DailyPriceDetailID IS NOT NULL THEN dpd.Price
	    END 	 AS 'CashPricePerBushel'
	 , CASE WHEN pt.ContractAdjustmentRate IS NOT NULL THEN CAST(pt.ContractAdjustmentRate*pt.DryBushels AS decimal (18,2) )
				ELSE 0
				END AS 'ContractAdjustmentAmount'
     , dbo.cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_SCHEDULE_ID_FOR_FEED_MILL_AND_DATE(cn.FeedMillID, pt.DeliveryDate) AS 'MoistureValuationMethodScheduleID'
     , dbo.cffn_CORN_PURCHASING_MOISTURE_DEDUCTION_BY_FEEDMILL_AND_DATE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID, ct.SentToDryer, pt.MoistureRateAdj) AS 'MoistureDiscount'
     , (pt.DryBushels/(1 + dbo.cffn_CORN_PURCHASING_SHRINK_DEDUCTION_BY_FEEDMILL_AND_DATE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID, ct.SentToDryer)))*dbo.cffn_CORN_PURCHASING_MOISTURE_DEDUCTION_BY_FEEDMILL_AND_DATE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID, ct.SentToDryer, pt.MoistureRateAdj)  AS 'MoistureDeductionAmount'
     , dbo.cffn_CORN_PURCHASING_MOISTURE_DEDUCTION_DETAIL_SELECT_BY_DATE_AND_RANGE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID) AS 'MoistureScheduleID'
     , (pt.DryBushels/(1 + dbo.cffn_CORN_PURCHASING_SHRINK_DEDUCTION_BY_FEEDMILL_AND_DATE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID, ct.SentToDryer))) * (dbo.cffn_CORN_PURCHASING_TOTAL_DRYING_DISCOUNT_BY_FEEDMILL_AND_DATE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID, ct.SentToDryer, pt.DryingRateAdj, dbo.cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_FOR_FEED_MILL_AND_DATE(cn.FeedMillID, pt.DeliveryDate), pt.ContractID)) AS 'DryingChargesAmount'
     , dbo.cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_ID_BY_DATE_AND_RANGE(dbo.cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_FOR_FEED_MILL_AND_DATE(cn.FeedMillID, pt.DeliveryDate), pt.DeliveryDate, ct.Moisture, ct.FeedMillID) AS 'DryingChargesScheduleID'
     , dbo.cffn_CORN_PURCHASING_SHRINK_DEDUCTION_BY_FEEDMILL_AND_DATE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID, ct.SentToDryer) AS 'ShrinkDiscount'
     , dbo.cffn_CORN_PURCHASING_GPA_SHRINK_DEDUCTION_DETAIL_SELECT_BY_DATE_AND_RANGE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID) AS 'ShrinkScheduleID'
     , pt.DryBushels * (dbo.cffn_CORN_PURCHASING_TOTAL_TEST_WEIGHT_DISCOUNT_BY_FEEDMILL_AND_DATE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID, ct.TestWeight, pt.TestWeightRateAdj, dbo.cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_FOR_FEED_MILL_AND_DATE(cn.FeedMillID, pt.DeliveryDate), pt.ContractID))  AS 'TestWeightAmount'
     , dbo.cffn_CORN_PURCHASING_GPA_TEST_WEIGHT_ID_BY_DATE_AND_RANGE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID) AS 'TestWeightScheduleID'
     , pt.DryBushels *(dbo.cffn_CORN_PURCHASING_FOREIGN_MATERIAL_DISCOUNT_BY_FEEDMILL_AND_DATE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID, ct.ForeignMaterial, pt.ForeignMaterialRateAdj, dbo.cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_FOR_FEED_MILL_AND_DATE(cn.FeedMillID, pt.DeliveryDate), pt.ContractID))  AS 'ForeignMaterialAmount'
     , dbo.cffn_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_ID_SELECT_BY_DATE_AND_RANGE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID) AS 'ForeignMaterialScheduleID'
     , CASE WHEN cp.CornCheckOff = 1 AND ch.Active = 1 THEN (pt.DryBushels * ch.Rate)
				ELSE 0
				END AS 'CornCheckoffAmount'
     , CASE WHEN cp.EthanolCheckoff = 1 AND ch2.Active = 1 THEN (pt.DryBushels * ch2.Rate)
				ELSE 0
				END AS 'EthanolCheckoffAmount'
     , pt.DryBushels * (dbo.cffn_CORN_PURCHASING_GPA_HANDLING_CHARGE_BY_FEED_MILL_AND_DATE(pt.DeliveryDate, ct.FeedMillID, pt.HandlingRateAdj, pt.ContractID)) AS 'HandlingAmount'
     , dbo.cffn_CORN_PURCHASING_GPA_HANDLING_CHARGE_ID_BY_FEED_MILL_AND_DATE(ct.FeedMillID, pt.DeliveryDate) AS 'HandlingScheduleID'
     , pt.DryBushels * (dbo.cffn_CORN_PURCHASING_DEFERRED_PAYMENT_CHARGE_BY_FEED_MILL_AND_DATE(pt.DeliveryDate, ct.FeedMillID, pt.DeferredPaymentRateAdj, pt.ContractID)) AS 'DeferredPaymentAmount'
     , dbo.cffn_CORN_PURCHASING_GPA_DEFERRED_PAYMENT_ID_BY_FEED_MILL_AND_DATE(ct.FeedMillID, pt.DeliveryDate) AS 'DeferredPaymentScheduleID'
     , CASE WHEN cn.ContractNumber IS NOT NULL AND pt.PaymentTypeID = 2 AND cn.Futures IS NOT NULL AND cn.PricedBasis IS NOT NULL AND ib.ValuePrice IS NOT NULL AND pt.SentToInventory = 1 THEN ((cn.Futures + cn.PricedBasis) - ib.ValuePrice) * pt.DryBushels
				ELSE 0
				END AS 'DelayedCornPricingVarianceAmount'
     , CASE WHEN cn.ContractNumber IS NOT NULL THEN pt.DryBushels * cn.Premium_Deduct
				ELSE 0 
				END AS 'PurchaseCornOptionsAmount'
     , CASE WHEN pt.MiscAdj IS NOT NULL THEN pt.DryBushels * pt.MiscAdj
				ELSE 0
				END AS 'MiscellaneousAdjustmentAmount'
     , NULL AS 'FSAPaymentAmt'
     , NULL AS 'CheckNumber'
     , NULL AS 'APBatchNumber'
     , dbo.cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_FOR_FEED_MILL_AND_DATE(cn.FeedMillID, pt.DeliveryDate) AS 'MoistureMethod'
     , NULL AS 'CornClearingAmount'
     , NULL AS 'MarketVariance'
     , NULL AS 'AccountsPayableBatchType'
     , NULL AS 'FSALoanNumber'
     , dbo.cffn_CORN_PURCHASING_GPA_HANDLING_START_DATE_BY_FEED_MILL_AND_DATE(pt.DeliveryDate, ct.FeedMillID, pt.ContractID)  AS 'HandlingStartDate'
     , dbo.cffn_CORN_PURCHASING_DEFERRED_START_DATE(pt.ContractID) AS 'DeferredStartDate'
     , ((CASE WHEN @CornPrice IS NOT NULL THEN @CornPrice
		WHEN pt.PaymentTypeID = 2 AND cn.ContractNumber IS NOT NULL AND cn.Futures IS NOT NULL AND cn.PricedBasis IS NOT NULL THEN (cn.Futures + cn.PricedBasis)
	    WHEN qt.QuoteID IS NOT NULL THEN qt.Price  
	    WHEN dpd.DailyPriceDetailID IS NOT NULL THEN dpd.Price
	    END) * pt.DryBushels  ) +
		(pt.DryBushels/(1 + dbo.cffn_CORN_PURCHASING_SHRINK_DEDUCTION_BY_FEEDMILL_AND_DATE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID, ct.SentToDryer))) * (dbo.cffn_CORN_PURCHASING_TOTAL_DRYING_DISCOUNT_BY_FEEDMILL_AND_DATE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID, ct.SentToDryer, pt.DryingRateAdj, dbo.cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_FOR_FEED_MILL_AND_DATE(cn.FeedMillID, pt.DeliveryDate), pt.ContractID)) +
	    (pt.DryBushels/(1 + dbo.cffn_CORN_PURCHASING_SHRINK_DEDUCTION_BY_FEEDMILL_AND_DATE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID, ct.SentToDryer)))*dbo.cffn_CORN_PURCHASING_MOISTURE_DEDUCTION_BY_FEEDMILL_AND_DATE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID, ct.SentToDryer, pt.MoistureRateAdj) +
	    (pt.DryBushels * (dbo.cffn_CORN_PURCHASING_TOTAL_TEST_WEIGHT_DISCOUNT_BY_FEEDMILL_AND_DATE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID, ct.TestWeight, pt.TestWeightRateAdj, dbo.cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_FOR_FEED_MILL_AND_DATE(cn.FeedMillID, pt.DeliveryDate), pt.ContractID))) +
	    (pt.DryBushels *(dbo.cffn_CORN_PURCHASING_FOREIGN_MATERIAL_DISCOUNT_BY_FEEDMILL_AND_DATE(pt.DeliveryDate, ct.Moisture, ct.FeedMillID, ct.ForeignMaterial, pt.ForeignMaterialRateAdj, dbo.cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_FOR_FEED_MILL_AND_DATE(cn.FeedMillID, pt.DeliveryDate), pt.ContractID))) +
	    (CASE WHEN cp.CornCheckOff = 1 AND ch.Active = 1 THEN (pt.DryBushels * ch.Rate)
				ELSE 0
				END) +
		(CASE WHEN cp.EthanolCheckoff = 1 AND ch2.Active = 1 THEN (pt.DryBushels * ch2.Rate)
				ELSE 0
				END) +
		(CASE WHEN pt.ContractAdjustmentRate IS NOT NULL THEN CAST(pt.ContractAdjustmentRate*pt.DryBushels AS decimal (18,2) )
				ELSE 0
				END) +
		(CASE WHEN pt.MiscAdj IS NOT NULL THEN pt.DryBushels * pt.MiscAdj
				ELSE 0
				END) +
		(pt.DryBushels * (dbo.cffn_CORN_PURCHASING_GPA_HANDLING_CHARGE_BY_FEED_MILL_AND_DATE(pt.DeliveryDate, ct.FeedMillID, pt.HandlingRateAdj, pt.ContractID))) +
		(pt.DryBushels * (dbo.cffn_CORN_PURCHASING_DEFERRED_PAYMENT_CHARGE_BY_FEED_MILL_AND_DATE(pt.DeliveryDate, ct.FeedMillID, pt.DeferredPaymentRateAdj, pt.ContractID))) +
		(pt.DryBushels * cn.Premium_Deduct)	 AS 'NetPaymentPerBushel'
     
FROM cft_PARTIAL_TICKET (NOLOCK) pt
LEFT JOIN cft_CORN_TICKET (NOLOCK) ct ON pt.FullTicketID = ct.TicketID
LEFT JOIN cft_CONTRACT (NOLOCK) cn ON pt.ContractID = cn.ContractID
LEFT JOIN cft_CONTRACT_TYPE (NOLOCK) cnt ON cn.ContractTypeID = cnt.ContractTypeID
LEFT JOIN cft_QUOTE (NOLOCK) qt ON pt.QuoteID = qt.QuoteID
LEFT JOIN [$(SolomonApp)].dbo.Vendor (NOLOCK) v on qt.CornProducerID = v.VendId
LEFT JOIN cft_DAILY_PRICE_DETAIL (NOLOCK) dpd ON pt.DailyPriceDetailID = dpd.DailyPriceDetailID
LEFT JOIN cft_CORN_PRODUCER (NOLOCK) cp ON pt.CornProducerID = cp.CornProducerID
LEFT JOIN cft_CHECKOFF (NOLOCK) ch ON ct.FeedMillID = ch.FeedMillID AND ch.CheckoffTypeID = 1
LEFT JOIN cft_CHECKOFF (NOLOCK) ch2 ON ct.FeedMillID = ch2.FeedMillID AND ch2.CheckoffTypeID = 2
LEFT JOIN cft_INVENTORY_BATCH (NOLOCK) ib ON pt.PartialTicketID = ib.PartialTicketID
WHERE pt.SentToAccountsPayable = 0
ORDER BY pt.DeliveryDate

CREATE TABLE #REPORT_DATA
(	SettlementID int
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
,	SumTotal decimal(18,4)
,   comments varchar(9))

	INSERT INTO #REPORT_DATA
	SELECT
		cfv_SETTLEMENT.SettlementID
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
	,	cast(cast(COALESCE((cft_Partial_Ticket.DryBushels),0) * COALESCE(cfv_SETTLEMENT.ActualPricePerBushel,0) as numeric(14,2))
		
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
	, NULL
	, substring(cft_Corn_Ticket.comments,1,9) as comments		-- 20130424 as per Amy's request

	FROM #TEMP_SETTLEMENT cfv_SETTLEMENT (NOLOCK)

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
	AND cft_Partial_Ticket.SentToAccountsPayable = 0
	WHERE cfv_SETTLEMENT.Delivery_VendorID LIKE RTRIM(@CornProducerID)
	ORDER BY cfv_SETTLEMENT.Delivery_VendorID, SettlementID


DECLARE
	@SettlementID as int
,	@LastDryBushels as decimal(18,4)
,	@LastDollarAmount as decimal(18,2)
,	@SplitPercentage as float
,   @LastSumTotal as decimal(18,4)
,	@RowCount as int

IF @TotalRequestedPaid IS NOT NULL AND @TotalRequestedBushels IS NULL BEGIN
	UPDATE r3
	SET r3.SumTotal = runAvg
	FROM #REPORT_DATA r3
	INNER JOIN	(
				SELECT r1.DeliveryVendorID, r1.SettlementID, SUM(r2.Total) AS runAvg
				FROM #REPORT_DATA r1
				JOIN #REPORT_DATA r2 ON (r1.SettlementID >= r2.SettlementID) AND (r1.DeliveryDate >= r2.DeliveryDate) AND r1.DeliveryVendorID = r2.DeliveryVendorID
				GROUP BY r1.DeliveryDate, r1.DeliveryVendorID, r1.SettlementID
				) data ON data.SettlementID = r3.SettlementID
	
	SELECT TOP 1 @LastDollarAmount = Total, @SettlementID = SettlementID
	FROM #REPORT_DATA
	WHERE SumTotal >= @TotalRequestedPaid
	ORDER BY DeliveryDate, FullTicketNumber, PartialTicketNumber
	
	SELECT @RowCount = COUNT(*)
	FROM #REPORT_DATA
	
	IF @RowCount > 1 BEGIN	
		SELECT @LastSumTotal = @TotalRequestedPaid - MAX(SumTotal)
		FROM #REPORT_DATA
		WHERE SumTotal < @TotalRequestedPaid
		
		IF @LastSumTotal < @LastDollarAmount BEGIN
			SET @SplitPercentage = @LastSumTotal/@LastDollarAmount
		END
		ELSE BEGIN
			SET @SplitPercentage = @TotalRequestedPaid/@LastDollarAmount
		END
	END
	ELSE BEGIN
		SELECT @SplitPercentage = @TotalRequestedPaid/Total
		FROM #REPORT_DATA
	END
	
	IF @SplitPercentage IS NOT NULL BEGIN
		UPDATE #REPORT_DATA
		SET SumWetBushels = SumWetBushels * @SplitPercentage, DryBushels = DryBushels * @SplitPercentage, MoistureDeductionAmount = MoistureDeductionAmount * @SplitPercentage, DryingCharge = DryingCharge * @SplitPercentage
			, TestWeightCharge = TestWeightCharge * @SplitPercentage, ForeignMaterialCharge = ForeignMaterialCharge * @SplitPercentage, HandlingCharge = HandlingCharge * @SplitPercentage
			, CornCheckoff = CornCheckoff * @SplitPercentage, Total = Total * @SplitPercentage, SumTotal = @TotalRequestedPaid
		WHERE SettlementID = @SettlementID
	END
	
	IF @LastSumTotal < @LastDollarAmount BEGIN
		SELECT *
		FROM #REPORT_DATA
		WHERE SumTotal < @TotalRequestedPaid

		UNION

		SELECT *
		FROM #REPORT_DATA
		WHERE SettlementID = @SettlementID
		ORDER BY SumTotal
	END
	ELSE IF @LastSumTotal IS NULL AND @RowCount > 1 BEGIN
		SELECT *
		FROM #REPORT_DATA
		WHERE SumTotal <= @TotalRequestedPaid
	END

	ELSE BEGIN
		SELECT *
		FROM #REPORT_DATA
		ORDER BY DeliveryDate, FullTicketNumber, PartialTicketNumber
	END
END
ELSE IF @TotalRequestedPaid IS NULL AND @TotalRequestedBushels IS NOT NULL BEGIN

	UPDATE r3
	SET r3.SumTotal = runAvg
	FROM #REPORT_DATA r3
	INNER JOIN	(
				SELECT r1.DeliveryVendorID, r1.SettlementID, SUM(r2.DryBushels) AS runAvg
				FROM #REPORT_DATA r1
				JOIN #REPORT_DATA r2 ON (r1.SettlementID >= r2.SettlementID) AND (r1.DeliveryDate >= r2.DeliveryDate) AND r1.DeliveryVendorID = r2.DeliveryVendorID
				GROUP BY r1.DeliveryDate, r1.DeliveryVendorID, r1.SettlementID
				) data ON data.SettlementID = r3.SettlementID	
	
	SELECT TOP 1 @LastDryBushels = DryBushels, @SettlementID = SettlementID
	FROM #REPORT_DATA
	WHERE SumTotal >= @TotalRequestedBushels
	ORDER BY DeliveryDate, FullTicketNumber, PartialTicketNumber
	
	SELECT @RowCount = COUNT(*)
	FROM #REPORT_DATA
	
	IF @RowCount > 1 BEGIN	
		SELECT @LastSumTotal = @TotalRequestedBushels - MAX(SumTotal)
		FROM #REPORT_DATA
		WHERE SumTotal< @TotalRequestedBushels

		IF @LastSumTotal < @LastDryBushels BEGIN	
			SET @SplitPercentage = @LastSumTotal/@LastDryBushels
		END	
		ELSE BEGIN
			SET @SplitPercentage = @TotalRequestedBushels/@LastDryBushels
		END	









	END
	ELSE BEGIN
		SELECT @SplitPercentage = @TotalRequestedBushels/DryBushels
		FROM #REPORT_DATA
	END
	
	IF @SplitPercentage IS NOT NULL BEGIN
		UPDATE #REPORT_DATA
		SET SumWetBushels = SumWetBushels * @SplitPercentage, DryBushels = DryBushels * @SplitPercentage, MoistureDeductionAmount = MoistureDeductionAmount * @SplitPercentage, DryingCharge = DryingCharge * @SplitPercentage
			, TestWeightCharge = TestWeightCharge * @SplitPercentage, ForeignMaterialCharge = ForeignMaterialCharge * @SplitPercentage, HandlingCharge = HandlingCharge * @SplitPercentage
			, CornCheckoff = CornCheckoff * @SplitPercentage, Total = Total * @SplitPercentage, SumTotal = @TotalRequestedBushels
		WHERE SettlementID = @SettlementID
	END

	IF @LastSumTotal < @LastDryBushels BEGIN
		SELECT *
		FROM #REPORT_DATA
		WHERE SumTotal < @TotalRequestedBushels

		UNION

		SELECT *
		FROM #REPORT_DATA
		WHERE SettlementID = @SettlementID
		ORDER BY SumTotal
	END
	ELSE IF @LastSumTotal IS NULL AND @RowCount > 1 BEGIN
		SELECT *
		FROM #REPORT_DATA
		WHERE SumTotal <= @TotalRequestedBushels
	END





	ELSE BEGIN
	SELECT *
		FROM #REPORT_DATA
	END

END
ELSE BEGIN
	SELECT *
	FROM #REPORT_DATA
	ORDER BY DeliveryDate, FullTicketNumber, PartialTicketNumber
END

drop table #REPORT_DATA
DROP TABLE #TEMP_SETTLEMENT
END

