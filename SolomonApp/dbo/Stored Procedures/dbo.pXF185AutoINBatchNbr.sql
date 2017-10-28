CREATE PROCEDURE pXF185AutoINBatchNbr 
	AS 
    	SELECT LastBatNbr 
	FROM INSetup

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185AutoINBatchNbr] TO [MSDSL]
    AS [dbo];

