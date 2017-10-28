CREATE PROCEDURE pXU010PJProj_Site 
	-- CREATED BY: CANDERSON
	-- CREATED ON: 2/6/2006
	@ProjectID varchar (16) 
	AS 
    	SELECT s.* FROM cftSite s
	JOIN PJProj p on 'PS'+s.SiteID=p.Project
	WHERE p.Project = @ProjectID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXU010PJProj_Site] TO [MSDSL]
    AS [dbo];

