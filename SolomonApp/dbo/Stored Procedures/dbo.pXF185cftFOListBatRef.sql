CREATE PROCEDURE pXF185cftFOListBatRef 
	@parm1 varchar (10), 
	@parm2 varchar (10), 
	@parm3 varchar(10) 
	AS 
    	SELECT * 
	FROM cftFOList 
	WHERE BatNbr = @parm1 
	AND RefNbr=@parm2 
	AND OrdNbr LIKE @parm3
	ORDER BY OrdNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftFOListBatRef] TO [MSDSL]
    AS [dbo];

