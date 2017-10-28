
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 07/29/2009
-- Description:	CENTRAL DATA - Deletes a phone record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CD_PHONE_DELETE
(
	@PhoneID			int
)
AS
BEGIN
	DELETE [$(CentralData)].dbo.Phone
	WHERE PhoneID = @PhoneID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_PHONE_DELETE] TO [db_sp_exec]
    AS [dbo];

