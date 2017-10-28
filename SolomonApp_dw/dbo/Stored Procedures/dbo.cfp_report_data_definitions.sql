


-- ==================================================================
-- Author:		SRipley
-- Create date: 2014-04-04
-- Description:	Report data defnitions
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_report_data_definitions]
	@ReportID int
AS

-----------------------------------------------------------------
-- Report Data
-----------------------------------------------------------------

SELECT dd.[DataElement]
      ,dd.[DataDefinition]
      ,dd.[Calculation]
      ,rdd.rel_attribute
  FROM [CFApp_PigManagement].[dbo].[cft_REPORT_DATA_DEFINITION] rdd (nolock)
  inner join [CFApp_PigManagement].[dbo].[cft_DATA_DEFINITION] dd (nolock)
	on rdd.datadefinitionid = dd.datadefinitionid
  where rdd.reportid = @ReportID
  order by dataelement




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_report_data_definitions] TO [CorpReports]
    AS [dbo];

