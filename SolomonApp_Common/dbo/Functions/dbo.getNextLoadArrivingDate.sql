
-- =============================================
-- Author:	Matt Dawson
-- Create date:	1/9/2008
-- Description:	Gets the date teh next load is arriving for teh barn
-- Parameters: 	@DestContactID, @BarnNbr, @StartDate, @EndDate
-- =============================================
Create Function [dbo].[getNextLoadArrivingDate]
	(@ContactID int, @BarnNbr varchar(10), @StartDate datetime, @EndDate datetime)
RETURNS datetime

AS
BEGIN
DECLARE @MinDate datetime

SET @MinDate = 
(
select
Min(PM.MovementDate)
from dbo.cftPM PM (NOLOCK)
where PM.MovementDate between @StartDate and dateadd(day,4,@EndDate)
--and PM.PigTypeID in ('02','03')
--and PM.Highlight<>'0'
and cast(PM.DestContactID as int) = @ContactID
and rtrim(PM.DestBarnNbr) = rtrim(@BarnNbr)
and pm.Highlight <> 255 
and pm.Highlight <> -65536
)
RETURN @MinDate 
END




GO
GRANT CONTROL
    ON OBJECT::[dbo].[getNextLoadArrivingDate] TO [MSDSL]
    AS [dbo];

