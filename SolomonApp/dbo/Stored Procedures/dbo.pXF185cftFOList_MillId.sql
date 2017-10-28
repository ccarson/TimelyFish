CREATE PROCEDURE pXF185cftFOList_MillId 
	@parm1 varchar (6), 
	@parm2 varchar (26) 
	AS 
    	SELECT * 
	FROM cftFOList 
	WHERE MillId = @parm1 
	AND SortOrd LIKE @parm2
	ORDER BY SortOrd

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftFOList_MillId] TO [MSDSL]
    AS [dbo];

