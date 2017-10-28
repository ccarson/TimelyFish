CREATE PROCEDURE pXU010Batch_GLBatNbr 
	-- CREATED BY: TJones
	-- CREATED ON: 6/06/05
	@parm1 varchar (10) 
	AS 
    	SELECT * FROM Batch
	WHERE BatNbr = @parm1
	AND Module = 'GL'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXU010Batch_GLBatNbr] TO [MSDSL]
    AS [dbo];

