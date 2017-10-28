-- ==================================================
-- Author:		Brian Cesafsky
-- Create date: 07/20/2009
-- Description:	Returns all contact's accreditations
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_ACCREDITATION_SELECT_BY_CONTACT_ID]
(
	@ContactID		int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
        AccreditationID
        ,ContactID
		,AccreditationTypeID
		,AccreditationNumber
		,AccreditationState
		,AccreditationExpirationDate
      FROM dbo.cft_CONTACT_ACCREDITATION (NOLOCK)
      WHERE (ContactID = @ContactID)
      ORDER BY AccreditationExpirationDate, AccreditationState

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_ACCREDITATION_SELECT_BY_CONTACT_ID] TO [db_sp_exec]
    AS [dbo];

