CREATE PROCEDURE pXF185Batch_BatMod 
	@parm1 varchar (10), 
	@parm2 varchar (2) 
	as 
	SELECT * FROM Batch 
	WHERE BatNbr = @parm1 
	AND Module = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185Batch_BatMod] TO [MSDSL]
    AS [dbo];

