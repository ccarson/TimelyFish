
-- =============================================
-- Author:	Matt Dawson
-- Create date:	1/20/2011
-- Description:	gets the last vet visit date prior to movement date
-- Parameters: 	@SiteContactID, @MovementDate
-- =============================================
Create Function [dbo].[getVetLastVisit_TestDate_orig]
	(@SiteContactID int, @MovementDate datetime)
RETURNS datetime

AS
BEGIN
DECLARE @VisitDate datetime

SET @VisitDate = 
(
select
max(ActualTestDate)
from pigdata.dbo.SiteHealthAssuranceTest (NOLOCK)
where SiteContactID = @SiteContactID
and ActualTestDate <= @MovementDate
)
RETURN @VisitDate 
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[getVetLastVisit_TestDate_orig] TO PUBLIC
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[getVetLastVisit_TestDate_orig] TO [se\sqlreporthelene]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[getVetLastVisit_TestDate_orig] TO [MSDSL]
    AS [dbo];

