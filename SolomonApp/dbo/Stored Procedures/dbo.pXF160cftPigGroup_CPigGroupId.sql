CREATE PROCEDURE pXF160cftPigGroup_CPigGroupId 
	@parm1 varchar (10), 
	@parm2 varchar (10) 
	as 
    	SELECT * FROM cftPigGroup 
	WHERE SiteContactId = @parm1 
	AND PigGroupId LIKE @parm2
	ORDER BY PigGroupId
