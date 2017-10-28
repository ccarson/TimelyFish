
CREATE Proc [dbo].[pXF51850SummaryFilename] as
    SELECT DISTINCT SummaryFileName 
	FROM cftPigSaleBatch 
	WHERE Processed <> 1
	AND SummaryFileName <> ''


