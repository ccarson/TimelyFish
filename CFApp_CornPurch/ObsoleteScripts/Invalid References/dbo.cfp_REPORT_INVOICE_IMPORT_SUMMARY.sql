-- =============================================
-- Author:		Matt Dawson
-- Create date: 09/11/2008
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_INVOICE_IMPORT_SUMMARY]
(	
	@APBatchNumber VARCHAR(10)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @mytbl table
(	APBatchNumber varchar(10)
,	FeedMillID char(10)
,	FeedMillName varchar(50)
,	PaymentType varchar(50)
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
,	GrainTransportAmount money)

INSERT INTO @mytbl
SELECT	cft_SETTLEMENT.APBatchNumber
,	cft_FEED_MILL.FeedMillID
,	cft_FEED_MILL.Name 'FeedMillName'
,	CASE cft_SETTLEMENT.AccountsPayableBatchType
		WHEN 1 THEN 'ACH'
		WHEN 2 THEN 'Check'
		ELSE 'N/A'
	END 'PaymentType'
,	COALESCE(SUM(cft_SETTLEMENT.CornClearingAmount),0) 'CornClearing'
,	COALESCE(SUM(cft_SETTLEMENT.CornCheckoffAmount),0) 'CornCheckoffAmount'
,	COALESCE(SUM(cft_SETTLEMENT.EthanolCheckoffAmount),0) 'EthanolCheckoffAmount'
,	COALESCE(SUM(cft_SETTLEMENT.DryingChargesAmount),0) 'DryingChargesAmount'
,	COALESCE(SUM(cft_SETTLEMENT.MoistureDeductionAmount),0) 'MoistureDeductionAmount'
,	COALESCE(SUM(cft_SETTLEMENT.DelayedCornPricingVarianceAmount),0) 'DelayedCornPricingVarianceAmount'
,	COALESCE(SUM(cft_SETTLEMENT.HandlingAmount),0) 'HandlingAmount'
,	COALESCE(SUM(cft_SETTLEMENT.ForeignMaterialAmount),0) 'ForeignMaterialAmount'
,	COALESCE(SUM(cft_SETTLEMENT.TestWeightAmount),0) 'TestWeightAmount'
,	COALESCE(SUM(cft_SETTLEMENT.MiscellaneousAdjustmentAmount),0) 'MiscellaneousAdjustmentAmount'
,	COALESCE(SUM(cft_SETTLEMENT.PurchaseCornOptionsAmount),0) 'PurchaseCornOptionsAmount'
,	COALESCE(SUM(cft_SETTLEMENT.DeferredPaymentAmount),0) 'DeferredPaymentAmount'
,	COALESCE(SUM(cft_SETTLEMENT.GrainTransportAmount),0) 'GrainTransportAmount'

FROM		dbo.cft_SETTLEMENT cft_SETTLEMENT (NOLOCK)
LEFT OUTER JOIN dbo.cft_CORN_TICKET cft_CORN_TICKET (NOLOCK)
	ON RTRIM(cft_CORN_TICKET.TicketNumber) = RTRIM(cft_SETTLEMENT.TicketNumber)
LEFT OUTER JOIN dbo.cft_FEED_MILL cft_FEED_MILL (NOLOCK)
	ON cft_FEED_MILL.FeedMillID = cft_CORN_TICKET.FeedMillID
WHERE RTRIM(cft_SETTLEMENT.APBatchNumber) = RTRIM(@APBatchNumber)
GROUP BY
	cft_SETTLEMENT.APBatchNumber
,	cft_FEED_MILL.FeedMillID
,	cft_FEED_MILL.Name
,	cft_SETTLEMENT.AccountsPayableBatchType


--unpivot
select x.APBatchNumber, x.FeedMillName, x.PaymentType, gl.ExpenseAccount, glt.name 'Description', x.CornClearing 'Amount'
from @mytbl x
left outer join dbo.cft_GL gl (nolock) on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 11 --CornClearing
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
union select x.APBatchNumber, x.FeedMillName, x.PaymentType, gl.ExpenseAccount, glt.name 'Description', x.CornCheckoffAmount 'Amount'
from @mytbl x
left outer join dbo.cft_GL gl (nolock) on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 17 --CornCheckoff
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
union select x.APBatchNumber, x.FeedMillName, x.PaymentType, gl.ExpenseAccount, glt.name 'Description', x.EthanolCheckoffAmount 'Amount'
from @mytbl x
left outer join dbo.cft_GL gl (nolock) on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 4 --EthanolCheckoff
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
union select x.APBatchNumber, x.FeedMillName, x.PaymentType, gl.ExpenseAccount, glt.name 'Description', x.DryingChargesAmount 'Amount'
from @mytbl x
left outer join dbo.cft_GL gl (nolock) on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 2 --DryingCharges
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
union select x.APBatchNumber, x.FeedMillName, x.PaymentType, gl.ExpenseAccount, glt.name 'Description', x.MoistureDeductionAmount 'Amount'
from @mytbl x
left outer join dbo.cft_GL gl (nolock) on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 14 --MoistureDeductionAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
union select x.APBatchNumber, x.FeedMillName, x.PaymentType, gl.ExpenseAccount, glt.name 'Description', x.DelayedCornPricingVarianceAmount 'Amount'
from @mytbl x
left outer join dbo.cft_GL gl (nolock) on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 8 --DelayedCornPricingVarianceAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
union select x.APBatchNumber, x.FeedMillName, x.PaymentType, gl.ExpenseAccount, glt.name 'Description', x.HandlingAmount 'Amount'
from @mytbl x
left outer join dbo.cft_GL gl on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 5 --HandlingAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
union select x.APBatchNumber, x.FeedMillName, x.PaymentType, gl.ExpenseAccount, glt.name 'Description', x.ForeignMaterialAmount 'Amount'
from @mytbl x
left outer join dbo.cft_GL gl on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 16 --ForeignMaterialAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
union select x.APBatchNumber, x.FeedMillName, x.PaymentType, gl.ExpenseAccount, glt.name 'Description', x.TestWeightAmount 'Amount'
from @mytbl x
left outer join dbo.cft_GL gl on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 15 --TestWeightAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
union select x.APBatchNumber, x.FeedMillName, x.PaymentType, gl.ExpenseAccount, glt.name 'Description', x.MiscellaneousAdjustmentAmount 'Amount'
from @mytbl x
left outer join dbo.cft_GL gl on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 10 --MiscellaneousAdjustmentAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
union select x.APBatchNumber, x.FeedMillName, x.PaymentType, gl.ExpenseAccount, glt.name 'Description', x.PurchaseCornOptionsAmount 'Amount'
from @mytbl x
left outer join dbo.cft_GL gl on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 9 --PurchaseCornOptionsAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
union select x.APBatchNumber, x.FeedMillName, x.PaymentType, gl.ExpenseAccount, glt.name 'Description', x.DeferredPaymentAmount 'Amount'
from @mytbl x
left outer join dbo.cft_GL gl on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 6 --DeferredPaymentAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid
union select x.APBatchNumber, x.FeedMillName, x.PaymentType, gl.ExpenseAccount, glt.name 'Description', x.GrainTransportAmount 'Amount'
from @mytbl x
left outer join dbo.cft_GL gl on gl.FeedMillID = x.FeedMillID and gl.GLTypeID = 1 --GrainTransportAmount
left outer join dbo.cft_GL_Type glt (nolock) on glt.gltypeid = gl.gltypeid



END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_INVOICE_IMPORT_SUMMARY] TO [db_sp_exec]
    AS [dbo];

