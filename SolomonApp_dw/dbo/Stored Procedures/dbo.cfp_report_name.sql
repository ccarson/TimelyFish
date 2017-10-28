


-- ==================================================================
-- Author:		SRipley
-- Create date: 2014-04-04
-- Description:	Report name
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_report_name]
	@ReportID int
AS

-----------------------------------------------------------------
-- Report Data
-----------------------------------------------------------------

select reportname
from [$(CFApp_PigManagement)].dbo.cft_report_name 
where reportid = @ReportID




