
-- =============================================
-- Author:		Matt Dawson
-- Create date: 10/30/2008
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_PURCHASE_SETTLEMENT_APCHECKNO]
	@MasterSettlementID varchar(100)
,	@PayTo_VendorID varchar(15)
AS
BEGIN

declare @mystr varchar(200)
set @mystr = ''

SELECT @mystr = @mystr + CheckNos.CheckNo + ', '
FROM (SELECT DISTINCT RTRIM(APAdjust.AdjgRefNbr) CheckNo
FROM dbo.cft_MASTER_SETTLEMENT cft_MASTER_SETTLEMENT (NOLOCK)
INNER JOIN dbo.cft_SETTLEMENT cft_SETTLEMENT (NOLOCK)
	ON RTRIM(cft_SETTLEMENT.APBatchNumber) = RTRIM(cft_MASTER_SETTLEMENT.APBatchNumber)
INNER JOIN [$(SolomonApp)].dbo.APDoc APDoc (NOLOCK)
	ON APDoc.InvcNbr = cft_SETTLEMENT.TicketNumber
	AND APDoc.BatNbr = cft_SETTLEMENT.APBatchNumber
	AND APDoc.VendID = cft_SETTLEMENT.PayTo_VendorID
--	ON RTRIM(APDoc.InvcNbr) = RTRIM(cft_SETTLEMENT.TicketNumber)
--	AND RTRIM(APDoc.BatNbr) = RTRIM(cft_SETTLEMENT.APBatchNumber)
--	AND RTRIM(APDoc.VendID) = RTRIM(cft_SETTLEMENT.PayTo_VendorID)
-- 2012-06-28 smr removed the rtrim, it is does not change the results, just prevents the use of a needed index.
INNER JOIN [$(SolomonApp)].dbo.APAdjust APAdjust (NOLOCK)
	ON APAdjust.AdjdDocType = APDoc.DocType
	AND APAdjust.AdjdRefNbr = APDoc.RefNbr
INNER JOIN [$(SolomonApp)].dbo.APDoc APDoc_1 (NOLOCK)
	ON APAdjust.AdjgAcct = APDoc_1.Acct
	AND APAdjust.AdjgPerPost = APDoc_1.PerPost
	AND APAdjust.AdjgDocType = APDoc_1.DocType
	AND APAdjust.AdjgRefNbr = APDoc_1.RefNbr
WHERE (((APDoc_1.DocType)='CK') AND ((APDoc_1.Status)<>'V'))
AND cft_MASTER_SETTLEMENT.MasterSettlementID = @MasterSettlementID
AND cft_SETTLEMENT.PayTo_VendorID = @PayTo_VendorID) CheckNos

if len(rtrim(replace(@mystr,',',''))) >= 1
	select @mystr = left(@mystr,len(@mystr)-1)
else
	select @mystr = NULL
select @mystr

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_PURCHASE_SETTLEMENT_APCHECKNO] TO [db_sp_exec]
    AS [dbo];

