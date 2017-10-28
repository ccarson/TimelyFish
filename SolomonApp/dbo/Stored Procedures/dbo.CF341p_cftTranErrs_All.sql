CREATE PROCEDURE CF341p_cftTranErrs_All 
	as 
    	SELECT * FROM cftTranErrs

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF341p_cftTranErrs_All] TO [MSDSL]
    AS [dbo];

