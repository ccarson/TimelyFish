-- =============================================
-- Author:	Andrey Derco
-- Create date: 11/05/2008
-- Description:	Returns all MasterSettlentIDs for given Corn Producer
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_MASTER_SETTLEMENT_SELECT]
(
   @CornProducerID	char(15), 
   @IncludeAll		bit
)
AS
BEGIN
	SET NOCOUNT ON;

IF @IncludeAll = 1 BEGIN

  SELECT 'X' AS APBatchNumber,
         '--All--' AS Name,
         '%' AS MasterSettlementID,
         0 AS DummyRec,
	 9999999999 as IDNum
  UNION ALL 

  SELECT APBatchNumber,
         MasterSettlementID,
         MasterSettlementID,
	 1 AS DummyRec,
	 cast(rtrim(right(MasterSettlementID,len(MasterSettlementID) - charindex('-',MasterSettlementID))) as numeric(10,0)) AS IDNum
  FROM dbo.cft_MASTER_SETTLEMENT
  WHERE (RTRIM(Delivery_VendorID) = RTRIM(@CornProducerID))

  ORDER BY 4,5 desc

END ELSE BEGIN

  SELECT APBatchNumber,
         MasterSettlementID AS Name,
         MasterSettlementID
  FROM dbo.cft_MASTER_SETTLEMENT
  WHERE (RTRIM(Delivery_VendorID) = RTRIM(@CornProducerID))

  ORDER BY cast(rtrim(right(MasterSettlementID,len(MasterSettlementID) - charindex('-',MasterSettlementID))) as numeric(10,0)) desc

END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MASTER_SETTLEMENT_SELECT] TO [db_sp_exec]
    AS [dbo];

