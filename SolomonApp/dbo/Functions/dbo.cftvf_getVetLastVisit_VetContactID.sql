
-- =============================================
-- Author:  		Chris Carson
-- Create date:   	2016-09-01
-- Description:   	Returns last vet visit contact prior to movement date
-- Parameters:    	@SiteContactID, @MovementDate
-- change:  		2016-09-01 
--						ccarson rewritten from scalar function
-- =============================================
CREATE FUNCTION 
	dbo.cftvf_getVetLastVisit_VetContactID( 
		@pSiteContactID int
	  , @pMovementDate 	datetime )
RETURNS TABLE 
AS

RETURN 

	SELECT TOP 1
		VetContactID
	FROM 
		dbo.cft_HAT_Vet_Schedule
	WHERE 
		SiteContactID = @pSiteContactID
		AND ActualTestDate !> @pMovementDate
	ORDER BY ActualTestDate DESC ; 


GO
GRANT SELECT
    ON OBJECT::[dbo].[cftvf_getVetLastVisit_VetContactID] TO PUBLIC
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[cftvf_getVetLastVisit_VetContactID] TO [se\sqlreporthelene]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cftvf_getVetLastVisit_VetContactID] TO [MSDSL]
    AS [dbo];

