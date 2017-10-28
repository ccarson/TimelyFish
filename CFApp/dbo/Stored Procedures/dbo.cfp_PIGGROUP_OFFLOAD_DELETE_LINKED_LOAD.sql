-- =============================================
-- Author:		Dave Killion
-- Create date: 11/28/2007
-- Description:	Deletes linked loads from cftpigoffload based upon the 
-- pig movement id passed into the proc
-- =============================================
CREATE PROCEDURE dbo.cfp_PIGGROUP_OFFLOAD_DELETE_LINKED_LOAD
	@PigMovementID char(10)
AS

DELETE	
	[$(SolomonApp)].dbo.cftpigoffload
where
	destpmid = @PigMovementID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIGGROUP_OFFLOAD_DELETE_LINKED_LOAD] TO [db_sp_exec]
    AS [dbo];

