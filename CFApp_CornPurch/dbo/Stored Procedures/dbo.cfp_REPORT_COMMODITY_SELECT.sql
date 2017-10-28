-- =============================================
-- Author:	Andrey Derco
-- Create date: 10/06/2008
-- Description:	Returns all Commodities
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_COMMODITY_SELECT]
(
   @IncludeAll	bit
)
AS
BEGIN
	SET NOCOUNT ON;

IF @IncludeAll = 1 BEGIN

  SELECT 0 AS CommodityID,
         '--All--' AS CommodityName
       
  UNION ALL 

  SELECT CommodityID,
         Description
  FROM dbo.cft_COMMODITY
  ORDER BY 2

END ELSE BEGIN

  SELECT CommodityID,
         Description AS CommodityName
  FROM dbo.cft_COMMODITY
  ORDER BY 2

END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_COMMODITY_SELECT] TO [db_sp_exec]
    AS [dbo];

