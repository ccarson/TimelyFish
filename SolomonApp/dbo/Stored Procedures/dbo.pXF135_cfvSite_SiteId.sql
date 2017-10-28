CREATE  Procedure pXF135_cfvSite_SiteId 
	@parm1 varchar (4) as 
	Select * 
	from cfvSite 
	Where SiteId Like @parm1
	Order by SiteId


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF135_cfvSite_SiteId] TO [MSDSL]
    AS [dbo];

