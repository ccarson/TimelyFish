CREATE PROCEDURE pXF130cftFOImpTransl_FI 
	@parm1 varchar (1), 
	@parm2 varchar (30) 
	AS 
    	SELECT * 
	FROM cftFOImpTransl 
	WHERE FileType = @parm1 
	AND ItemId = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF130cftFOImpTransl_FI] TO [MSDSL]
    AS [dbo];

