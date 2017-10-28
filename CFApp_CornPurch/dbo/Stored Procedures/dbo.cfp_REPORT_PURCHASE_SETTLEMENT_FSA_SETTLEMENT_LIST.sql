-- =============================================
-- Author:		Matt Dawson
-- Create date: 08/26/2009
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_PURCHASE_SETTLEMENT_FSA_SETTLEMENT_LIST]
(	@VendorID varchar(8000)
,	@APBatchNumber varchar(10) = NULL
,	@PaymentStart datetime
,	@PaymentEnd datetime)
AS
BEGIN

create table #Vendors (VendorID varchar(15))
insert into #Vendors select * from dbo.cffn_SPLIT_STRING(@VendorID,',')


SELECT distinct cft_Master_Settlement.MasterSettlementID 'SettlementID'
,	cast(rtrim(right(cft_Master_Settlement.MasterSettlementID,len(cft_Master_Settlement.MasterSettlementID) - charindex('-',cft_Master_Settlement.MasterSettlementID))) as numeric(10,0))
FROM dbo.cft_Settlement cft_Settlement (NOLOCK)
JOIN #Vendors v 
	on v.VendorID = cft_Settlement.PayTo_VendorID
JOIN dbo.cft_Master_Settlement cft_Master_Settlement (NOLOCK)
	on cft_Master_Settlement.APBatchNumber = cft_Settlement.APBatchNumber
	and cft_Master_Settlement.PayTo_VendorID = cft_Settlement.PayTo_VendorID
WHERE CONVERT(VARCHAR,PaymentDate,101) BETWEEN @PaymentStart AND @PaymentEnd
AND cft_Settlement.APBatchNumber LIKE isnull(@APBatchNumber,'%')
--ORDER BY cft_Master_Settlement.MasterSettlementID desc
ORDER BY cast(rtrim(right(cft_Master_Settlement.MasterSettlementID,len(cft_Master_Settlement.MasterSettlementID) - charindex('-',cft_Master_Settlement.MasterSettlementID))) as numeric(10,0)) desc

drop table #Vendors

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_PURCHASE_SETTLEMENT_FSA_SETTLEMENT_LIST] TO [db_sp_exec]
    AS [dbo];

