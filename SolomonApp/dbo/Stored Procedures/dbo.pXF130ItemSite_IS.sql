CREATE PROCEDURE pXF130ItemSite_IS 
	@parm1 varchar (30), 
	@parm2 varchar (10) 
	AS 
    	SELECT * 
	FROM ItemSite 
	WHERE InvtId = @parm1 
	AND SiteId = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF130ItemSite_IS] TO [MSDSL]
    AS [dbo];

