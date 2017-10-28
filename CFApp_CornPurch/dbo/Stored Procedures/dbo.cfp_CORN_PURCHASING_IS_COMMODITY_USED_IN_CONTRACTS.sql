
-- ===================================================================
-- Author:	Sergey Neskin
-- Create date: 21/08/2008
-- Description:	Is commodity used in opened contracts
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_IS_COMMODITY_USED_IN_CONTRACTS]
(
    @CommodityID	int
)
AS
BEGIN
SET NOCOUNT ON;

  DECLARE @CommodityInUse bit

  SELECT @CommodityInUse = 
		CASE WHEN EXISTS 
				(SELECT 1 FROM dbo.cft_CONTRACT WHERE ContractStatusID = 1 AND CommodityID = @CommodityID) 
			THEN 1 
			ELSE 0 
		END

  SELECT @CommodityInUse

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_IS_COMMODITY_USED_IN_CONTRACTS] TO [db_sp_exec]
    AS [dbo];

