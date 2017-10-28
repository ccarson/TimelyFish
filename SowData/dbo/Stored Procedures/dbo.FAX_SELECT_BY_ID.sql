-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FAX_SELECT_BY_ID]
(
	@FAX_ID						[varchar](50)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select isnull (FAX_ID,'') as FAX_ID, 
		isnull (FARM_ID,'Unknown') as FARM_ID,
		isnull (FAX_ORIGINATING_NUMBER,'') as FAX_ORIGINATING_NUMBER,
		isnull (FAX_PROCESSED,'N') as FAX_PROCESSED,
		FAX_PROCESSED_DATE
	from dbo.FAX_INFORMATION
	where FAX_ID = @FAX_ID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FAX_SELECT_BY_ID] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[FAX_SELECT_BY_ID] TO [se\analysts]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FAX_SELECT_BY_ID] TO [MyFaxService]
    AS [dbo];

