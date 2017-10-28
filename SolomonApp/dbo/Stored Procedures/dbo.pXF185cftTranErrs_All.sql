CREATE PROCEDURE pXF185cftTranErrs_All 
	AS 
	SELECT * 
	FROM cftTranErrs

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftTranErrs_All] TO [MSDSL]
    AS [dbo];

