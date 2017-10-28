



-- ==================================================================
-- Author:		SRipley
-- Create date: 1/5/2013
-- Description:	Report Name list
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_report_list]
AS

-----------------------------------------------------------------
-- Report Data
-----------------------------------------------------------------

SELECT [ReportID]
  ,[ReportName]
  ,[ReportDescription]
FROM [CFApp_PigManagement].[dbo].[cft_REPORT_NAME]
order by reportname





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_report_list] TO [CorpReports]
    AS [dbo];

