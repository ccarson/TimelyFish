-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[cfs_FARM_SELECT_ALL_ID]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    Select FarmID from FarmSetup Order By FarmID
END

Grant EXECUTE on [dbo].[cfs_FARM_SELECT_ALL_ID] to [SQLEssbaseSproc]


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfs_FARM_SELECT_ALL_ID] TO [SQLEssbaseSproc]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfs_FARM_SELECT_ALL_ID] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[cfs_FARM_SELECT_ALL_ID] TO [se\analysts]
    AS [dbo];

