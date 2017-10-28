
-- ===================================================================
-- Author:  Matt Dawson
-- Create date: 09/24/2008
-- Description: Selects data for Voided Tickets Report
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_VOIDED_TICKETS]
(
	@TicketNumber VARCHAR(4000)
)
AS
BEGIN

DECLARE @mytbl table
(	TicketNumber varchar(20)
,	SolomonBatchNumber varchar(10)
,	DeliveryDate datetime
,	SolomonBatchType char(2)
,	SolomonBatchTypeSort INT
,	FeedMillID char(10)
,	FeedMillName varchar(50)
,	CornProducerID varchar(15)
,	CornProducerName varchar(50)
,	ContractNumber varchar(72)
,	ExpenseAccount varchar(50)
,	Amount money
,	CornClearing money
,	CornCheckoffAmount money
,	EthanolCheckoffAmount money
,	DryingChargesAmount money
,	MoistureDeductionAmount money
,	DelayedCornPricingVarianceAmount money
,	HandlingAmount money
,	ForeignMaterialAmount money
,	TestWeightAmount money
,	MiscellaneousAdjustmentAmount money
,	PurchaseCornOptionsAmount money
,	DeferredPaymentAmount money
,	ContractAdjustmentAmount money)


-----------------------------------------------------------------------------------------------------
--IN
-----------------------------------------------------------------------------------------------------
INSERT INTO @mytbl
SELECT	
	pt.TicketNumber
,	ib.InventoryBatchNumber
,	CONVERT(VARCHAR,pt.DeliveryDate,101)
,	'IN'
,	1
,	fm.FeedMillID
,	fm.Name
,	pt.CornProducerID
,	V.RemitName
,	contract.ContractNumber
,	gl.ExpenseAccount
,	CAST(ib.InventoryAmount * CAST(ib.StandardPrice AS NUMERIC(18,2)) AS NUMERIC(18,2))
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
FROM		dbo.cft_INVENTORY_BATCH ib (NOLOCK)
INNER JOIN dbo.cffn_SPLIT_STRING(@TicketNumber, ',') TN ON RTRIM(ib.TicketNumber) = RTRIM(TN.Value)
LEFT OUTER JOIN dbo.cft_CORN_TICKET ct (NOLOCK)
	ON RTRIM(ct.TicketNumber) = RTRIM(ib.TicketNumber)
LEFT OUTER JOIN dbo.cft_FEED_MILL fm (NOLOCK)
	ON fm.FeedMillID = ct.FeedMillID
LEFT OUTER JOIN dbo.cft_PARTIAL_TICKET pt (NOLOCK)
	ON pt.FullTicketID = ct.TicketID
LEFT OUTER JOIN dbo.cft_CORN_PRODUCER cp (NOLOCK)
	ON RTRIM(cp.CornProducerID) = RTRIM(pt.CornProducerID)
LEFT OUTER JOIN dbo.cft_Vendor V (NOLOCK)
	ON V.VendId = cp.CornProducerID
LEFT OUTER JOIN dbo.cft_CONTRACT contract (NOLOCK)
	ON contract.ContractID = pt.ContractID
LEFT OUTER JOIN cft_GL gl (NOLOCK)
	ON gl.FeedMillID = fm.FeedMillID
	AND gl.GLTypeID = 17 --Corn Checkoff


-----------------------------------------------------------------------------------------------------
--GL
-----------------------------------------------------------------------------------------------------
INSERT INTO @mytbl
SELECT	
	pt.TicketNumber
,	ib.GeneralLedgerBatchNumber
,	ct.DeliveryDate		--DeliveryDate
,	'GL'
,	2
,	fm.FeedMillID		--FeedMillID
,	fm.Name			--FeedMillName
,	pt.CornProducerID	--CornProducerID
,	V.RemitName		--CornProducerName
,	contract.ContractNumber
,	gl.ExpenseAccount
,	(CAST(ib.InventoryAmount * CAST(ib.ValuePrice AS NUMERIC(18,2)) AS NUMERIC(18,2))) - (CAST(ib.InventoryAmount * CAST(ib.StandardPrice AS NUMERIC(18,2)) AS NUMERIC(18,2)))
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
FROM		dbo.cft_INVENTORY_BATCH ib (NOLOCK)
INNER JOIN dbo.cffn_SPLIT_STRING(@TicketNumber, ',') TN ON RTRIM(ib.TicketNumber) = RTRIM(TN.Value)
LEFT OUTER JOIN dbo.cft_CORN_TICKET ct (NOLOCK)
	ON RTRIM(ct.TicketNumber) = RTRIM(ib.TicketNumber)
LEFT OUTER JOIN dbo.cft_FEED_MILL fm (NOLOCK)
	ON fm.FeedMillID = ct.FeedMillID
LEFT OUTER JOIN dbo.cft_PARTIAL_TICKET pt (NOLOCK)
	ON pt.FullTicketID = ct.TicketID
LEFT OUTER JOIN dbo.cft_CORN_PRODUCER cp (NOLOCK)
	ON RTRIM(cp.CornProducerID) = RTRIM(pt.CornProducerID)
LEFT OUTER JOIN dbo.cft_Vendor V (NOLOCK)
	ON V.VendId = cp.CornProducerID
LEFT OUTER JOIN dbo.cft_CONTRACT contract (NOLOCK)
	ON contract.ContractID = pt.ContractID
LEFT OUTER JOIN cft_GL gl (NOLOCK)
	ON gl.FeedMillID = fm.FeedMillID
	AND gl.GLTypeID = 11 --Corn Clearing


-----------------------------------------------------------------------------------------------------
--AP
-----------------------------------------------------------------------------------------------------
INSERT INTO @mytbl
SELECT	
	s.TicketNumber
,	s.APBatchNumber
,	ct.DeliveryDate		--DeliveryDate
,	'AP'
,	3
,	fm.FeedMillID
,	fm.Name
,	pt.CornProducerID
,	V.RemitName
,	contract.ContractNumber
,	NULL
,	NULL
,	COALESCE(SUM(s.CornClearingAmount),0) 'CornClearing'
,	COALESCE(SUM(s.CornCheckoffAmount),0) 'CornCheckoffAmount'
,	COALESCE(SUM(s.EthanolCheckoffAmount),0) 'EthanolCheckoffAmount'
,	COALESCE(SUM(s.DryingChargesAmount),0) 'DryingChargesAmount'
,	COALESCE(SUM(s.MoistureDeductionAmount),0) 'MoistureDeductionAmount'
,	COALESCE(SUM(s.DelayedCornPricingVarianceAmount),0) 'DelayedCornPricingVarianceAmount'
,	COALESCE(SUM(s.HandlingAmount),0) 'HandlingAmount'
,	COALESCE(SUM(s.ForeignMaterialAmount),0) 'ForeignMaterialAmount'
,	COALESCE(SUM(s.TestWeightAmount),0) 'TestWeightAmount'
,	COALESCE(SUM(s.MiscellaneousAdjustmentAmount),0) 'MiscellaneousAdjustmentAmount'
,	COALESCE(SUM(s.PurchaseCornOptionsAmount),0) 'PurchaseCornOptionsAmount'
,	COALESCE(SUM(s.DeferredPaymentAmount),0) 'DeferredPaymentAmount'
,	COALESCE(SUM(s.ContractAdjustmentAmount),0) 'ContractAdjustmentAmount'
FROM		dbo.cft_SETTLEMENT s (NOLOCK)
INNER JOIN dbo.cffn_SPLIT_STRING(@TicketNumber, ',') TN ON RTRIM(s.TicketNumber) = RTRIM(TN.Value)
LEFT OUTER JOIN dbo.cft_CORN_TICKET ct (NOLOCK)
	ON RTRIM(ct.TicketNumber) = RTRIM(s.TicketNumber)
LEFT OUTER JOIN dbo.cft_FEED_MILL fm (NOLOCK)
	ON fm.FeedMillID = ct.FeedMillID
LEFT OUTER JOIN dbo.cft_PARTIAL_TICKET pt (NOLOCK)
	ON s.PartialTicketID = pt.PartialTicketID
LEFT OUTER JOIN dbo.cft_CONTRACT contract (NOLOCK)
	ON contract.ContractID = pt.ContractID
LEFT OUTER JOIN dbo.cft_CORN_PRODUCER cp (NOLOCK)
	ON RTRIM(cp.CornProducerID) = RTRIM(pt.CornProducerID)
LEFT OUTER JOIN dbo.cft_Vendor V (NOLOCK)
	ON V.VendId = cp.CornProducerID
--WHERE RTRIM(s.TicketNumber) = RTRIM(@TicketNumber)
GROUP BY
	s.TicketNumber
,	s.APBatchNumber
,	ct.DeliveryDate
,	fm.FeedMillID
,	fm.Name
,	pt.CornProducerID
,	V.RemitName
,	contract.ContractNumber

-----------------------------------------------------------------------------------------------------
--TICKETS NOT SENT TO AP\IB
-----------------------------------------------------------------------------------------------------
INSERT INTO @mytbl
SELECT	
	pt.TicketNumber
,	NULL
,	ct.DeliveryDate
,	NULL
,	4
,	fm.FeedMillID
,	fm.Name
,	pt.CornProducerID
,	V.RemitName
,	c.ContractNumber
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
FROM		dbo.cft_PARTIAL_TICKET pt (NOLOCK)
INNER JOIN dbo.cft_CORN_TICKET ct
	   ON ct.TicketID = pt.FullTicketID
INNER JOIN dbo.cffn_SPLIT_STRING(@TicketNumber, ',') TN 
	ON RTRIM(ct.TicketNumber) = RTRIM(TN.Value)
INNER JOIN dbo.cft_FEED_MILL fm (NOLOCK)
	ON fm.FeedMillID = ct.FeedMillID
INNER JOIN dbo.cft_CORN_PRODUCER cp (NOLOCK)
	ON RTRIM(cp.CornProducerID) = RTRIM(pt.CornProducerID)
INNER JOIN dbo.cft_Vendor V (NOLOCK)
	ON V.VendId = cp.CornProducerID
LEFT OUTER JOIN dbo.cft_CONTRACT c
	ON c.ContractID = pt.ContractID
LEFT OUTER JOIN dbo.cft_SETTLEMENT s
	ON s.PartialTicketID = pt.PartialTicketID
LEFT OUTER JOIN dbo.cft_INVENTORY_BATCH ib
	ON ib.TicketNumber=  ct.TicketNumber
WHERE s.SettlementID IS NULL AND ib.InventoryBatchId IS NULL
--WHERE RTRIM(s.TicketNumber) = RTRIM(@TicketNumber)
GROUP BY
	pt.TicketNumber
,	ct.DeliveryDate
,	fm.FeedMillID
,	fm.Name
,	pt.CornProducerID
,	V.RemitName
,	c.ContractNumber

-----------------------------------------------------------------------------------------------------
--COMPILE RESULTS
-----------------------------------------------------------------------------------------------------
SELECT 
	TicketNumber
,	SolomonBatchNumber
,	DeliveryDate
,	SolomonBatchType
,	SolomonBatchTypeSort
,	FeedMillID
,	FeedMillName
,	CornProducerID
,	CornProducerName
,	ContractNumber
,	ExpenseAccount
,	Amount
FROM @mytbl
--WHERE SolomonBatchType NOT IN ('IN','GL')
WHERE ISNULL(SolomonBatchType,'') NOT IN ('AP')

--unpivot
union select x.TicketNumber, x.SolomonBatchNumber, x.DeliveryDate, 'AP', 3, x.FeedMillID, x.FeedMillName, x.CornProducerID, x.CornProducerName, x.ContractNumber, gl.ExpenseAccount, x.CornClearing
from @mytbl x
left outer join dbo.cft_GL gl (nolock) on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 11 --CornClearing
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
where x.SolomonBatchType = 'AP'
and x.CornClearing <> 0
union select x.TicketNumber, x.SolomonBatchNumber, x.DeliveryDate, 'AP', 3, x.FeedMillID, x.FeedMillName, x.CornProducerID, x.CornProducerName, x.ContractNumber, gl.ExpenseAccount, x.CornCheckoffAmount
from @mytbl x
left outer join dbo.cft_GL gl (nolock) on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 17 --CornCheckoff
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
where x.SolomonBatchType = 'AP'
and x.CornCheckoffAmount <> 0
union select x.TicketNumber, x.SolomonBatchNumber, x.DeliveryDate, 'AP', 3, x.FeedMillID, x.FeedMillName, x.CornProducerID, x.CornProducerName, x.ContractNumber, gl.ExpenseAccount, x.EthanolCheckoffAmount
from @mytbl x
left outer join dbo.cft_GL gl (nolock) on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 4 --EthanolCheckoff
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
where x.SolomonBatchType = 'AP'
and x.EthanolCheckoffAmount <> 0
union select x.TicketNumber, x.SolomonBatchNumber, x.DeliveryDate, 'AP', 3, x.FeedMillID, x.FeedMillName, x.CornProducerID, x.CornProducerName, x.ContractNumber, gl.ExpenseAccount, x.DryingChargesAmount
from @mytbl x
left outer join dbo.cft_GL gl (nolock) on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 2 --DryingCharges
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
where x.SolomonBatchType = 'AP'
and x.DryingChargesAmount <> 0
union select x.TicketNumber, x.SolomonBatchNumber, x.DeliveryDate, 'AP', 3, x.FeedMillID, x.FeedMillName, x.CornProducerID, x.CornProducerName, x.ContractNumber, gl.ExpenseAccount, x.MoistureDeductionAmount
from @mytbl x
left outer join dbo.cft_GL gl (nolock) on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 14 --MoistureDeductionAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
where x.SolomonBatchType = 'AP'
and x.MoistureDeductionAmount <> 0
union select x.TicketNumber, x.SolomonBatchNumber, x.DeliveryDate, 'AP', 3, x.FeedMillID, x.FeedMillName, x.CornProducerID, x.CornProducerName, x.ContractNumber, gl.ExpenseAccount, x.DelayedCornPricingVarianceAmount
from @mytbl x
left outer join dbo.cft_GL gl (nolock) on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 8 --DelayedCornPricingVarianceAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
where x.SolomonBatchType = 'AP'
and x.DelayedCornPricingVarianceAmount <> 0
union select x.TicketNumber, x.SolomonBatchNumber, x.DeliveryDate, 'AP', 3, x.FeedMillID, x.FeedMillName, x.CornProducerID, x.CornProducerName, x.ContractNumber, gl.ExpenseAccount, x.HandlingAmount
from @mytbl x
left outer join dbo.cft_GL gl on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 5 --HandlingAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
where x.SolomonBatchType = 'AP'
and x.HandlingAmount <> 0
union select x.TicketNumber, x.SolomonBatchNumber, x.DeliveryDate, 'AP', 3, x.FeedMillID, x.FeedMillName, x.CornProducerID, x.CornProducerName, x.ContractNumber, gl.ExpenseAccount, x.ForeignMaterialAmount
from @mytbl x
left outer join dbo.cft_GL gl on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 16 --ForeignMaterialAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
where x.SolomonBatchType = 'AP'
and x.ForeignMaterialAmount <> 0
union select x.TicketNumber, x.SolomonBatchNumber, x.DeliveryDate, 'AP', 3, x.FeedMillID, x.FeedMillName, x.CornProducerID, x.CornProducerName, x.ContractNumber, gl.ExpenseAccount, x.TestWeightAmount
from @mytbl x
left outer join dbo.cft_GL gl on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 15 --TestWeightAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
where x.SolomonBatchType = 'AP'
and x.TestWeightAmount <> 0
union select x.TicketNumber, x.SolomonBatchNumber, x.DeliveryDate, 'AP', 3, x.FeedMillID, x.FeedMillName, x.CornProducerID, x.CornProducerName, x.ContractNumber, gl.ExpenseAccount, x.MiscellaneousAdjustmentAmount
from @mytbl x
left outer join dbo.cft_GL gl on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 10 --MiscellaneousAdjustmentAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
where x.SolomonBatchType = 'AP'
and x.MiscellaneousAdjustmentAmount <> 0
union select x.TicketNumber, x.SolomonBatchNumber, x.DeliveryDate, 'AP', 3, x.FeedMillID, x.FeedMillName, x.CornProducerID, x.CornProducerName, x.ContractNumber, gl.ExpenseAccount, x.PurchaseCornOptionsAmount
from @mytbl x
left outer join dbo.cft_GL gl on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 9 --PurchaseCornOptionsAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
where x.SolomonBatchType = 'AP'
and x.PurchaseCornOptionsAmount <> 0
union select x.TicketNumber, x.SolomonBatchNumber, x.DeliveryDate, 'AP', 3, x.FeedMillID, x.FeedMillName, x.CornProducerID, x.CornProducerName, x.ContractNumber, gl.ExpenseAccount, x.DeferredPaymentAmount
from @mytbl x
left outer join dbo.cft_GL gl on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 6 --DeferredPaymentAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
where x.SolomonBatchType = 'AP'
and x.DeferredPaymentAmount <> 0
union select x.TicketNumber, x.SolomonBatchNumber, x.DeliveryDate, 'AP', 3, x.FeedMillID, x.FeedMillName, x.CornProducerID, x.CornProducerName, x.ContractNumber, gl.ExpenseAccount, x.ContractAdjustmentAmount
from @mytbl x
left outer join dbo.cft_GL gl on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 1 --ContractAdjustmentAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
where x.SolomonBatchType = 'AP'
and x.ContractAdjustmentAmount <> 0

ORDER BY TicketNumber, SolomonBatchTypeSort

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_VOIDED_TICKETS] TO [db_sp_exec]
    AS [dbo];

