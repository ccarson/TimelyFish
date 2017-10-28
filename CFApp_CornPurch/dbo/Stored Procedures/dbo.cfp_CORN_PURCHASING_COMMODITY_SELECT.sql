
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/17/2008
-- Description:	Selects all Commodity records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_COMMODITY_SELECT]
AS
BEGIN
SET NOCOUNT ON;

SELECT CommodityID,
       Name,
       Description,
       Active,
       IsDefault,
       CreatedDateTime,
       CreatedBy,
       UpdatedDateTime,
       UpdatedBy
FROM dbo.cft_COMMODITY
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMODITY_SELECT] TO [db_sp_exec]
    AS [dbo];

