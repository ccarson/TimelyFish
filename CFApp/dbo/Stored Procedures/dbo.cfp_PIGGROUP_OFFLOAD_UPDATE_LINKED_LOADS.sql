-- =============================================
-- Author:		Dave Killion
-- Create date: 11/29/2007
-- Description:	Used to remove existing records from
-- cftpigoffload for matching srcpmid. Also inserts a record into
-- cftpigoffload using the passed in parameters
-- =============================================
CREATE PROCEDURE dbo.cfp_PIGGROUP_OFFLOAD_UPDATE_LINKED_LOADS
	(@SourcePigMovementID int 
	,@DestinationPigMovementID int
	,@CreatedDateTime datetime
	,@CreatedProgram char(8)
	,@CreatedUser char(10)
	,@LastUpdatedDateTime datetime
	,@LastUpdatedProgram char(8)
	,@LastUpdatedUser char(10)
	,@NoteID int)

AS

	--First - delete any existing records from cftPigOffLoad where
	--matching srcpmid is found

DELETE
	[$(SolomonApp)].dbo.cftPigOffLoad
WHERE
	SrcPMID = @SourcePigMovementID

	-- Next - insert a new record into cftPigOffLoad using the 
	-- passed in parameters
INSERT into
	[$(SolomonApp)].dbo.cftPigOffLoad
	(crtd_datetime
	,crtd_prog
	,crtd_user
	,DestPMId
	,Lupd_DateTime
	,Lupd_Prog
	,Lupd_User
	,NoteID
	,SrcPMId)
VALUES
	(@CreatedDateTime
	,@CreatedProgram
	,@CreatedUser
	,@DestinationPigMovementID
	,@LastUpdatedDateTime
	,@LastUpdatedProgram
	,@LastUpdatedUser
	,@NoteID
	,@SourcePigMovementID)


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIGGROUP_OFFLOAD_UPDATE_LINKED_LOADS] TO [db_sp_exec]
    AS [dbo];

