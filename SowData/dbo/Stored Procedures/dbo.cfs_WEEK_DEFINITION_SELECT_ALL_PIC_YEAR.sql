-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[cfs_WEEK_DEFINITION_SELECT_ALL_PIC_YEAR]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    Select Distinct PICYear From WeekDefinition ORDER BY PICYear
END

GRANT EXECUTE ON [dbo].[cfs_WEEK_DEFINITION_SELECT_ALL_PIC_YEAR] to [SQLEssbaseSproc]


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfs_WEEK_DEFINITION_SELECT_ALL_PIC_YEAR] TO [SQLEssbaseSproc]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfs_WEEK_DEFINITION_SELECT_ALL_PIC_YEAR] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[cfs_WEEK_DEFINITION_SELECT_ALL_PIC_YEAR] TO [se\analysts]
    AS [dbo];

