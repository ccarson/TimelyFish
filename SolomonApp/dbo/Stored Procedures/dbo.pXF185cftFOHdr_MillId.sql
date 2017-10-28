CREATE PROCEDURE pXF185cftFOHdr_MillId 
	@parm1 varchar (6) 
	AS 
	SELECT * 
	FROM cftFOHdr 
	WHERE MillId = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftFOHdr_MillId] TO [MSDSL]
    AS [dbo];

