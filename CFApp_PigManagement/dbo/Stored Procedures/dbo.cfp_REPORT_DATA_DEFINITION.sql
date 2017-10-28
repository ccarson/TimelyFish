-- =============================================
-- Author:		Matt Brandt
-- Create date: 10/5/2010
-- Description:	This procedure returns the data definitions to be used in a report for a given ReportID
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_DATA_DEFINITION] 
	-- Add the parameters for the stored procedure here
	@ReportID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

Select RTrim(d.DataElement) As DataElement, d.DataDefinition
From dbo.cft_REPORT_NAME r 
	Inner Join dbo.cft_REPORT_DATA_DEFINITION rd ON r.ReportID = rd.ReportID
	Inner Join dbo.cft_DATA_DEFINITION d ON d.DataDefinitionID = rd.DataDefinitionID
Where r.ReportID = @ReportID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_DATA_DEFINITION] TO [SE\Analysts]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_DATA_DEFINITION] TO [db_sp_exec]
    AS [dbo];

