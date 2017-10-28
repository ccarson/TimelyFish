-- =====================================================================
-- Author:		Matt Dawson
-- Create date: 04/14/2010
-- Description:	Returns the Pic Date String from passed in date
-- =====================================================================


CREATE FUNCTION [dbo].[cffn_GET_PIC_DATE_STRING_BY_DATE] (@DateParm datetime)
RETURNS CHAR(6)
AS


BEGIN
	DECLARE @CurrentPICWeek CHAR(6)

	SELECT @CurrentPICWeek = RIGHT(PicYear,2) + 'WK' + RIGHT('00' + PicWeek,2) from [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) where @DateParm between WeekOfDate and WeekEndDate

    RETURN @CurrentPICWeek
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_GET_PIC_DATE_STRING_BY_DATE] TO [CorpReports]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_GET_PIC_DATE_STRING_BY_DATE] TO [db_sp_exec]
    AS [dbo];

