
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 07/21/2009
-- Description:	Deletes a contact accreditation record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CONTACT_ACCREDITATION_DELETE
(
	@AccreditationID		int
)
AS
BEGIN
	DELETE dbo.cft_CONTACT_ACCREDITATION
	WHERE	AccreditationID = @AccreditationID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_ACCREDITATION_DELETE] TO [db_sp_exec]
    AS [dbo];

