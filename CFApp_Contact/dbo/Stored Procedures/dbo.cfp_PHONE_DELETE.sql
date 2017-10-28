
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 04/33/2008
-- Description:	Deletes a phone record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_PHONE_DELETE
(
	@PhoneID		int
)
AS
BEGIN
	DELETE dbo.cft_PHONE
	WHERE PhoneID = @PhoneID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PHONE_DELETE] TO [db_sp_exec]
    AS [dbo];

