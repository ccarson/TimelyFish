-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 07/20/2009
-- Description:	Updates a record in cft_CONTACT_ACCREDITATION_UPDATE
-- ==================================================================
CREATE PROCEDURE dbo.cfp_CONTACT_ACCREDITATION_UPDATE
(
		@AccreditationID					int
		,@AccreditationTypeID				int
		,@AccreditationNumber				varchar(10)
		,@AccreditationState				varchar(2)
		,@AccreditationExpirationDate		datetime
		,@UpdatedBy							varchar(50)
)
AS
BEGIN

UPDATE dbo.cft_CONTACT_ACCREDITATION
   SET [AccrediTationTypeID] = @AccreditationTypeID
		,[AccreditationNumber] = @AccreditationNumber
		,[AccreditationState] = @AccreditationState
		,[AccreditationExpirationDate] = @AccreditationExpirationDate
		,[UpdatedDateTime] = getdate()
		,[UpdatedBy] = @UpdatedBy

 WHERE 
	[AccreditationID] = @AccreditationID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_ACCREDITATION_UPDATE] TO [db_sp_exec]
    AS [dbo];

