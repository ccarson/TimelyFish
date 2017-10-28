
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 10/16/2009
-- Description:	Deletes a Target Line record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_TARGET_LINE_DELETE]
(
	@TargetLineID		int
)
AS
BEGIN
	SET NOCOUNT ON

	DELETE dbo.cft_TARGET_LINE
	WHERE TargetLineID = @TargetLineID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TARGET_LINE_DELETE] TO [db_sp_exec]
    AS [dbo];

