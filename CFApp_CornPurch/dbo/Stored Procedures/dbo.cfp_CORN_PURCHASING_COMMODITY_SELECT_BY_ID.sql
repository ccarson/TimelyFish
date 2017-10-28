
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/17/2008
-- Description:	Selects Commodity record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_COMMODITY_SELECT_BY_ID]
(
    @CommodityID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT Name,
       Description,
       Active,
       IsDefault,
       CreatedDateTime,
       CreatedBy,
       UpdatedDateTime,
       UpdatedBy
FROM dbo.cft_COMMODITY
WHERE CommodityID = @CommodityID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMODITY_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

