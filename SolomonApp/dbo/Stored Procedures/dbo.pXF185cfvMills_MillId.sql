CREATE PROCEDURE pXF185cfvMills_MillId 
	@parm1 varchar (10), 
	@parm2 varchar (6) 
	AS 
    	SELECT v.* FROM cfvMills v 
	JOIN cftMillSite s ON v.MillId = s.MillId
	WHERE (s.CpnyId = @parm1 or s.CpnyId Is Null) 
	AND v.MillId LIKE @parm2
	ORDER BY v.MillId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cfvMills_MillId] TO [MSDSL]
    AS [dbo];

