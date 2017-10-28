
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 07/20/2009
-- Description:	Creates new contact accreditation record
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CONTACT_ACCREDITATION_INSERT
(
	@ContactID						int
   ,@AccreditationTypeID			int
   ,@AccreditationNumber			varchar(10)
   ,@AccreditationState				varchar(2)
   ,@AccreditationExpirationDate	datetime
   ,@CreatedBy						varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT dbo.cft_CONTACT_ACCREDITATION
	(
		[ContactID]
	   ,[AccreditationTypeID]
	   ,[AccreditationNumber]
	   ,[AccreditationState]
	   ,[AccreditationExpirationDate]
	   ,[CreatedBy]
	) 
	VALUES 
	(
		@ContactID
	   ,@AccreditationTypeID
	   ,@AccreditationNumber
	   ,@AccreditationState
	   ,@AccreditationExpirationDate
	   ,@CreatedBy
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_ACCREDITATION_INSERT] TO [db_sp_exec]
    AS [dbo];

