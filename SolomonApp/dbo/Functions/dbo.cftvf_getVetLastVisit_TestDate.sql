
CREATE FUNCTION 
	dbo.cftvf_getVetLastVisit_TestDate( 
		@pSiteContactID	int
	  , @pMovementDate	datetime )
RETURNS TABLE 

AS

RETURN

SELECT
	VisitDate = MAX( ActualTestDate ) 
FROM 
	dbo.cft_HAT_Vet_Schedule
WHERE 
	SiteContactID = @pSiteContactID
		AND ActualTestDate !> @pMovementDate

GO
GRANT SELECT
    ON OBJECT::[dbo].[cftvf_getVetLastVisit_TestDate] TO PUBLIC
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[cftvf_getVetLastVisit_TestDate] TO [se\sqlreporthelene]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cftvf_getVetLastVisit_TestDate] TO [MSDSL]
    AS [dbo];

