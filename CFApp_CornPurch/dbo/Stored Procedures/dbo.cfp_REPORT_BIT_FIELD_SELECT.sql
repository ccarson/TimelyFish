-- =============================================
-- Author:		Matt Dawson
-- Create date: 08/14/2008
-- Description:	Returns bit field values
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_BIT_FIELD_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT '%' 'Value', 'Any' 'Name'
UNION ALL 
SELECT '1' 'Value', 'Yes' 'Name'
UNION ALL
SELECT '0' 'Value', 'No' 'Name'
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_BIT_FIELD_SELECT] TO [db_sp_exec]
    AS [dbo];

