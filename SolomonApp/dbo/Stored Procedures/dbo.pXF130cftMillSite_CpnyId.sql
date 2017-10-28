CREATE PROCEDURE pXF130cftMillSite_CpnyId 
	@parm1 varchar (10) 
	AS 
	SELECT * 
	FROM cftMillSite 
	WHERE CpnyId = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF130cftMillSite_CpnyId] TO [MSDSL]
    AS [dbo];

