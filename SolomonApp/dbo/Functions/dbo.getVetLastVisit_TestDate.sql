--getVetLastVisit_VetContactID
--getVetLastVisit_testdate
-- =============================================
-- Author:  Matt Dawson
-- Create date:   1/20/2011
-- Description:   gets the last vet visit date prior to movement date
-- Parameters:    @SiteContactID, @MovementDate
-- change:  2014-07-07 sripley  (pigdata database to be obsoleted replaced old table with new table
-- pigdata.dbo.SiteHealthAssuranceTest replaced by [SolomonApp].[dbo].[cft_HAT_Vet_Schedule]
-- =============================================
create Function [dbo].[getVetLastVisit_TestDate]
      (@SiteContactID int, @MovementDate datetime)
RETURNS datetime

AS
BEGIN
DECLARE @VisitDate datetime

SET @VisitDate = 
(
select
max(ActualTestDate)
--from pigdata.dbo.SiteHealthAssuranceTest (NOLOCK)
from [SolomonApp].[dbo].[cft_HAT_Vet_Schedule] (nolock)
where SiteContactID = @SiteContactID
and ActualTestDate <= @MovementDate
)
RETURN @VisitDate 
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[getVetLastVisit_TestDate] TO PUBLIC
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[getVetLastVisit_TestDate] TO [se\sqlreporthelene]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[getVetLastVisit_TestDate] TO [MSDSL]
    AS [dbo];

