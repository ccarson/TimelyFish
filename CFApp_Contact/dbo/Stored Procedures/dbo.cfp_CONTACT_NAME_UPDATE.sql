-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 04/28/2008
-- Description:	Updates a record in cft_CONTACT
-- ============================================================
CREATE PROCEDURE dbo.cfp_CONTACT_NAME_UPDATE
(
		@ContactID			int
		,@ContactName		varchar(50)
		,@UpdatedBy					varchar(50)
)
AS
BEGIN

UPDATE dbo.cft_CONTACT
   SET [ContactName] = @ContactName
		,[UpdatedBy] = @UpdatedBy

 WHERE 
		[ContactID] = @ContactID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_NAME_UPDATE] TO [db_sp_exec]
    AS [dbo];

