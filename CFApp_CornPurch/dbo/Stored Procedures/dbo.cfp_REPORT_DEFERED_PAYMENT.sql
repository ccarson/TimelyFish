






-- ===================================================================
-- Author:  Sergey Neskin
-- Create date: 08/04/2008
-- Description: Selects data for Defered Payment report
-- 2012-08-22  sripley modifications to meet user requirements
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_DEFERED_PAYMENT]
(
	@FeedMillname varchar(50)
	,@cornproducername varchar(30) 
	,@FROMDATE DATE, @TODATE DATE
)
AS
BEGIN
SET NOCOUNT ON;
if @FeedMillname = '--All--' set @FeedMillname = '%'
if @cornproducername = '--All--' set @cornproducername = '%'

SELECT 
	FM.Name AS FeedMillName,
	V.RemitName AS CornProducerName,
	C.ContractNumber AS ContractNumber,
	ct.Name as contracttype,
	c.DateEstablished,
	CASE 
		WHEN NOT C.SubsequenceNumber IS NULL THEN C.Bushels
		ELSE C.Bushels - dbo.cffn_GET_SUM_CHILD_BUSHELS(C.SequenceNumber, C.FeedMillID)
	END AS ContractedBushels,		
	c.DueDateFrom,
	c.duedateto,
	c.Cash as purchase_price,
	Tickets.AppliedBushels AS AppliedBushels,
	C.Bushels - (C.Bushels - dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(C.ContractID)) AS Balance,			-- Balance		
	C.DeferredPaymentDate AS deferredPaymentDate
FROM dbo.cft_FEED_MILL FM (nolock)
inner join dbo.cft_CONTRACT C (nolock)
	ON C.FeedMillID = FM.FeedMillID 
INNER JOIN dbo.cft_CONTRACT_TYPE CT (nolock) ON CT.ContractTypeID = C.ContractTypeID 
INNER JOIN [$(SolomonApp)].dbo.Vendor V (nolock) ON V.VendId = C.CornProducerID
LEFT OUTER JOIN dbo.cft_CONTRACT_TYPE CTPL (nolock) ON CTPL.ContractTypeID = C.LastContractTypeID
LEFT OUTER JOIN (   SELECT ContractID,SUM(DryBushels) AS AppliedBushels
                    FROM dbo.cft_PARTIAL_TICKET (nolock)
                    where ISNULL(SentToAccountsPayable, 0) <> 1 
                    GROUP BY ContractID
                ) AS Tickets ON Tickets.ContractID = C.ContractID
Where 1=1
and FM.Name LIKE @FeedMillname
AND V.RemitName LIKE @cornproducername
AND C.DeferredPaymentDate BETWEEN  isnull(@FROMDATE,'1900/01/01') AND isnull(@TODATE,'2200/01/01')
--AND CT.DeferredPayment = 1 
and c.DeferredPaymentDate is not null
AND C.ContractStatusID = 1	-- only want open contracts (1-open,2-close,3-void)

ORDER BY CornProducerID





END







GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_DEFERED_PAYMENT] TO [db_sp_exec]
    AS [dbo];

