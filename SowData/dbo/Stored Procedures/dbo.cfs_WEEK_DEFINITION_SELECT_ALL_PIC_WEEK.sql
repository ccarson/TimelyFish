-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[cfs_WEEK_DEFINITION_SELECT_ALL_PIC_WEEK]
(
	@PICYear					smallint
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    Select Distinct PICWeek 
	From dbo.WeekDefinition 
	WHERE PICYear = @PICYear
	ORDER BY PICWeek
END

GRANT EXECUTE ON [dbo].[cfs_WEEK_DEFINITION_SELECT_ALL_PIC_WEEK] to [SQLEssbaseSproc]



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfs_WEEK_DEFINITION_SELECT_ALL_PIC_WEEK] TO [SQLEssbaseSproc]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfs_WEEK_DEFINITION_SELECT_ALL_PIC_WEEK] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[cfs_WEEK_DEFINITION_SELECT_ALL_PIC_WEEK] TO [se\analysts]
    AS [dbo];

