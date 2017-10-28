-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[cfs_ESSBASE_SELECT_UPLOAD_TEMP_remove]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    	Select * from EssbaseUploadTemp ORDER BY FarmID, Account
END


GRANT EXECUTE ON [dbo].[cfs_ESSBASE_SELECT_UPLOAD_TEMP] TO [SQLEssbaseSproc]



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfs_ESSBASE_SELECT_UPLOAD_TEMP_remove] TO [SQLEssbaseSproc]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfs_ESSBASE_SELECT_UPLOAD_TEMP_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[cfs_ESSBASE_SELECT_UPLOAD_TEMP_remove] TO [se\analysts]
    AS [dbo];

