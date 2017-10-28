
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/17/2008
-- Description:	Selects all Commodity records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_COMMODITY_SELECT_DEFAULT]
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
WHERE IsDefault = 1
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMODITY_SELECT_DEFAULT] TO [db_sp_exec]
    AS [dbo];

