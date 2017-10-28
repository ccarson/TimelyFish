-- =============================================
-- Author:	Andrey Derco
-- Create date: 11/03/2008
-- Description:	Returns Commodity's name
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_COMMODITY_SELECT_NAME]
(
   @CommodityID int
)
AS
BEGIN
	SET NOCOUNT ON;

  SELECT Description
  FROM dbo.cft_COMMODITY
  WHERE CommodityID = @CommodityID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_COMMODITY_SELECT_NAME] TO [db_sp_exec]
    AS [dbo];

