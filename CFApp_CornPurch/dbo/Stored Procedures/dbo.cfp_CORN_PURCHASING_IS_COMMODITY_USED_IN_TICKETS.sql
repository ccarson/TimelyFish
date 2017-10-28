
-- ===================================================================
-- Author:	Sergey Neskin
-- Create date: 21/08/2008
-- Description:	Is commodity used in opened contracts
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_IS_COMMODITY_USED_IN_TICKETS]
(
    @CommodityID	int
)
AS
BEGIN
SET NOCOUNT ON;

  DECLARE @CommodityInUse bit

  SELECT @CommodityInUse = 
		CASE WHEN EXISTS 
				(	SELECT 1 FROM cft_PARTIAL_TICKET PT 
					INNER JOIN cft_CORN_TICKET CT ON CT.TicketID = PT.FullTicketID
					WHERE PT.PartialTicketStatusID = 1 AND CT.CommodityID = @CommodityID )
			THEN 1 
			ELSE 0 
		END

  SELECT @CommodityInUse

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_IS_COMMODITY_USED_IN_TICKETS] TO [db_sp_exec]
    AS [dbo];

