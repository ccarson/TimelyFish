-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 03/16/2008
-- Description:	Returns all Address Types
-- =============================================
CREATE PROCEDURE [dbo].[cfp_ADDRESS_TYPE_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT AddressTypeID
		, Description
FROM dbo.cft_ADDRESS_TYPE
Order By Description
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_ADDRESS_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];

