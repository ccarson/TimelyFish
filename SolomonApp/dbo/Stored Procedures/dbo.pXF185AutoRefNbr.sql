Create PROCEDURE pXF185AutoRefNbr 
	AS 
    	SELECT LastRefNbr 
	FROM cftFOSetup

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185AutoRefNbr] TO [MSDSL]
    AS [dbo];

