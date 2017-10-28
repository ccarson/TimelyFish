-- =============================================
-- Author:		Matt Dawson
-- Create date: 09/16/2008
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_PURCHASE_SETTLEMENT_FSA]
	@SettlementID varchar(8000)
,	@FSAOfficeID varchar(8000)
AS
BEGIN

create table #FSAOfficeID_Temp (FSAOfficeID varchar(100))
insert into #FSAOfficeID_Temp select * from dbo.cffn_SPLIT_STRING(@FSAOfficeID,',')

create table #SettlementID_Temp (SettlementID varchar(100))
insert into #SettlementID_Temp select * from dbo.cffn_SPLIT_STRING(@SettlementID,',')

SELECT
	cft_Settlement.SettlementID
,	cft_Corn_Ticket.FeedMillID
,	cft_Feed_Mill.Name 'FeedMillName'
,	cft_Feed_Mill.Address1 'FeedMillAddress1'
,	cft_Feed_Mill.Address2 'FeedMillAddress2'
,	cft_Feed_Mill.City 'FeedMillCity'
,	cft_Feed_Mill.State 'FeedMillState'
,	cft_Feed_Mill.Zip 'FeedMillZip'
,	Contact_PayTo_Vendor.ContactName 'PayToVendor'
,	Contact_FSA_Office.ContactName 'FSAOffice'
,	Address_FSA_Office.Address1 'FSAOfficeAddress1'
,	Address_FSA_Office.Address2 'FSAOfficeAddress2'
,	Address_FSA_Office.City 'FSAOfficeCity'
,	Address_FSA_Office.State 'FSAOfficeState'
,	Address_FSA_Office.Zip 'FSAOfficeZip'
,	cft_Corn_Ticket.Commodity
,	Vendor.Name 'CornProducerName'
,	CONVERT(VARCHAR, cft_Corn_Ticket.DeliveryDate, 101) 'DeliveryDate'
,	cft_Corn_Ticket.TicketNumber 'FullTicketNumber'
,	COALESCE(cft_Partial_Ticket.DryBushels,0) 'DryBushels'
,	COALESCE(cft_Settlement.NetPaymentPerBushel,0) 'NetPaymentPerBushel'
,	COALESCE(cft_Settlement.FSAPaymentAmt,0) 'FSAPaymentAmt'
,	cft_Settlement.FSALoanNumber


,	cast(case when (cft_Partial_Ticket.SentTOInventory = 1)
		then cast((COALESCE((cft_Partial_Ticket.DryBushels),0) * COALESCE(cft_INVENTORY_BATCH.ValuePrice,0)) as numeric(14,2))
		+ cast(COALESCE((cft_Partial_Ticket.DryBushels),0) 
		* (COALESCE(cft_SETTLEMENT.ActualPricePerBushel,0) - COALESCE(cft_INVENTORY_BATCH.ValuePrice,0)) as numeric(14,2))
		else cast(COALESCE((cft_Partial_Ticket.DryBushels),0) * COALESCE(cft_SETTLEMENT.ActualPricePerBushel,0) as numeric(14,2))
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
FROM		dbo.cft_Corn_Ticket cft_Corn_Ticket (NOLOCK)
LEFT OUTER JOIN dbo.cft_Partial_Ticket cft_Partial_Ticket (NOLOCK)
	ON	cft_Partial_Ticket.FullTicketID = cft_Corn_Ticket.TicketID
LEFT OUTER JOIN dbo.cft_INVENTORY_BATCH cft_INVENTORY_BATCH (NOLOCK)
	ON	cft_INVENTORY_BATCH.PartialTicketID = cft_Partial_Ticket.PartialTicketID
LEFT OUTER JOIN dbo.cft_Corn_Producer cft_Corn_Producer (NOLOCK)
	ON	RTRIM(cft_Corn_Producer.CornProducerID) = RTRIM(cft_Corn_Ticket.CornProducerID)
LEFT OUTER JOIN dbo.cft_FSA_OFFICE_CORN_PRODUCER cft_FSA_OFFICE_CORN_PRODUCER (NOLOCK)
	ON	RTRIM(cft_FSA_OFFICE_CORN_PRODUCER.CornProducerID) = RTRIM(cft_Corn_Ticket.CornProducerID)
LEFT OUTER JOIN dbo.cft_FSA_OFFICE cft_FSA_OFFICE (NOLOCK)
	ON	cft_FSA_OFFICE.FSAOfficeID = cft_FSA_OFFICE_CORN_PRODUCER.FSAOfficeID
INNER JOIN	#FSAOfficeID_Temp FSAOfficeID_Temp
	ON	FSAOfficeID_Temp.FSAOfficeID = cft_FSA_OFFICE.FSAOfficeID
LEFT OUTER JOIN [$(CFApp_Contact)].dbo.cft_Contact Contact_FSA_Office (NOLOCK)
	ON	Contact_FSA_Office.ContactID = cft_FSA_OFFICE.ContactID
LEFT OUTER JOIN [$(CFApp_Contact)].dbo.cft_Contact_Address Contact_Address_FSA_Office (NOLOCK)
	ON Contact_Address_FSA_Office.ContactID = Contact_FSA_Office.ContactID
	AND Contact_Address_FSA_Office.AddressTypeID = 1 --Physical Address
LEFT OUTER JOIN [$(CFApp_Contact)].dbo.cft_Address Address_FSA_Office (NOLOCK)
	ON Address_FSA_Office.AddressID = Contact_Address_FSA_Office.AddressID
LEFT OUTER JOIN dbo.cft_Vendor Vendor (NOLOCK)
	ON	RTRIM(Vendor.VendID) = RTRIM(cft_Corn_Producer.CornProducerID)
LEFT OUTER JOIN dbo.cft_Settlement cft_Settlement (NOLOCK)
	ON	RTRIM(cft_Settlement.TicketNumber) = RTRIM(cft_Corn_Ticket.TicketNumber)
LEFT OUTER JOIN dbo.cft_Master_Settlement cft_Master_Settlement (NOLOCK)
	ON	cft_Master_Settlement.APBatchNumber = cft_Settlement.APBatchNumber
	AND	cft_Master_Settlement.PayTo_VendorID = cft_Settlement.PayTo_VendorID
	AND	cft_Master_Settlement.Delivery_VendorID = cft_Settlement.Delivery_VendorID
INNER JOIN	#SettlementID_Temp SettlementID_Temp
	ON	SettlementID_Temp.SettlementID = cft_Master_Settlement.MasterSettlementID
LEFT OUTER JOIN dbo.cft_Corn_Producer CornProducerPayToVendor (NOLOCK)
	ON	RTRIM(CornProducerPayToVendor.CornProducerID) = RTRIM(cft_Settlement.PayTo_VendorID)
LEFT OUTER JOIN [$(CFApp_Contact)].dbo.cft_Contact Contact_PayTo_Vendor (NOLOCK)
	ON Contact_PayTo_Vendor.ContactID = CornProducerPayToVendor.ContactID
LEFT OUTER JOIN [$(CFApp_Contact)].dbo.cft_Contact_Address Contact_Address_PayTo_Vendor (NOLOCK)
	ON Contact_Address_PayTo_Vendor.ContactID = Contact_PayTo_Vendor.ContactID
	AND Contact_Address_PayTo_Vendor.AddressTypeID = 1 --Physical Address
LEFT OUTER JOIN [$(CFApp_Contact)].dbo.cft_Address Address_PayTo_Vendor (NOLOCK)
	ON Address_PayTo_Vendor.AddressID = Contact_Address_PayTo_Vendor.AddressID
LEFT OUTER JOIN dbo.cft_Contract cft_Contract (NOLOCK)
	ON cft_Contract.ContractID = cft_Partial_Ticket.ContractID
	AND cft_Corn_Ticket.DeliveryDate BETWEEN cft_Contract.DueDateFrom AND cft_Contract.DueDateTo
LEFT OUTER JOIN dbo.cft_Feed_Mill cft_Feed_Mill (NOLOCK)
	ON RTRIM(cft_Feed_Mill.FeedMillID) = RTRIM(cft_Corn_Ticket.FeedMillID)
--WHERE
--	cast(cft_Settlement.SettlementID as varchar) IN ( @SettlementID )
--AND	cft_FSA_OFFICE.FSAOfficeID IN ( @FSAOfficeID )


drop table #FSAOfficeID_Temp
drop table #SettlementID_Temp

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_PURCHASE_SETTLEMENT_FSA] TO [db_sp_exec]
    AS [dbo];

