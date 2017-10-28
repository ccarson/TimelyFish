
Create Procedure [dbo].[pUpdateBarnCapMultiplier]
 
as

UPDATE Barn
	SET CapMultiplier=2
	WHERE FacilityTypeID=5
	


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pUpdateBarnCapMultiplier] TO [MSDSL]
    AS [dbo];

