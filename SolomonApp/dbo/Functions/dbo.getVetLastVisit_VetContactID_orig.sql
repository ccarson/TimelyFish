
-- =============================================
-- Author:	Matt Dawson
-- Create date:	1/20/2011
-- Description:	gets the last vet visit contact prior to movement date
-- Parameters: 	@SiteContactID, @MovementDate
-- =============================================
Create Function [dbo].[getVetLastVisit_VetContactID_orig]
	(@SiteContactID int, @MovementDate datetime)
RETURNS datetime

AS
BEGIN
DECLARE @VetContactID int

SET @VetContactID = 
(
select distinct
main.TesterContactID
from pigdata.dbo.SiteHealthAssuranceTest main (NOLOCK)

join
	(select max(SiteHealthAssuranceTestID) SiteHealthAssuranceTestID
	from pigdata.dbo.SiteHealthAssuranceTest hat
	join
		(select 
			sitecontactid, 
			max(actualtestdate) actualtestdate
		from pigdata.dbo.SiteHealthAssuranceTest (NOLOCK) 
		where actualtestdate <= @MovementDate
		and sitecontactid = @SiteContactID
		group by sitecontactid) maxhat
	on maxhat.sitecontactid = hat.sitecontactid
	and maxhat.actualtestdate = hat.actualtestdate) getid
	on getid.SiteHealthAssuranceTestID = main.SiteHealthAssuranceTestID	

)
RETURN @VetContactID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[getVetLastVisit_VetContactID_orig] TO PUBLIC
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[getVetLastVisit_VetContactID_orig] TO [se\sqlreporthelene]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[getVetLastVisit_VetContactID_orig] TO [MSDSL]
    AS [dbo];

