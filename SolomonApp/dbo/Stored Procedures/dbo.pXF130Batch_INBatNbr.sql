CREATE PROCEDURE pXF130Batch_INBatNbr 
	@parm1 varchar (10) 
	AS 
	SELECT * 
	FROM Batch 
	WHERE Module = 'IN' 
	AND BatNbr = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF130Batch_INBatNbr] TO [MSDSL]
    AS [dbo];

