-- ================================================
-- Author:		Brian Cesafsky
-- Create date: 04/22/2008
-- Description:	Returns all Contact Phone Carriers
-- ================================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_PHONE_CARRIER_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT CarrierID
		,CarrierName
		,CarrierTextMessageAddress
FROM dbo.cft_CONTACT_CELL_PHONE_PROVIDER
Order By CarrierName
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_PHONE_CARRIER_SELECT] TO [db_sp_exec]
    AS [dbo];

