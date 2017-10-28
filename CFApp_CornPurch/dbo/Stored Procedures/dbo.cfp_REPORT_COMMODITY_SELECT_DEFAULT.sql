-- =============================================
-- Author:	Andrey Derco
-- Create date: 12/03/2008
-- Description:	Returns id of a default commodity
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_COMMODITY_SELECT_DEFAULT]
AS
BEGIN
	SET NOCOUNT ON;

SELECT CommodityID
FROM dbo.cft_COMMODITY
WHERE IsDefault = 1

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_COMMODITY_SELECT_DEFAULT] TO [db_sp_exec]
    AS [dbo];

