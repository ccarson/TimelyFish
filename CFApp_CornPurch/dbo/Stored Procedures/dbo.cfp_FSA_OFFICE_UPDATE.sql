-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 07/21/2008
-- Description:	Updates a record in cft_FSA_OFFICE
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_FSA_OFFICE_UPDATE]
(
		@FsaOfficeID			varchar(15)
		,@Active					bit
		,@UpdatedBy					varchar(50)
)
AS
BEGIN

UPDATE dbo.cft_FSA_OFFICE
   SET [Active] = @Active
		,[UpdatedBy] = @UpdatedBy

 WHERE 
	[FsaOfficeID] = @FsaOfficeID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FSA_OFFICE_UPDATE] TO [db_sp_exec]
    AS [dbo];

