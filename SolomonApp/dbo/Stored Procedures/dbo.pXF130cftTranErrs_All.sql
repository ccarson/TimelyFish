CREATE PROCEDURE pXF130cftTranErrs_All 
	AS 
	SELECT * 
	FROM cftTranErrs

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF130cftTranErrs_All] TO [MSDSL]
    AS [dbo];

