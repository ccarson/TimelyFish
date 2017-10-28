CREATE PROCEDURE pXF160cfvSite_ContactId 
	@parm1 varchar (6) 
	as 
    	SELECT * FROM cfvSite 
	WHERE ContactId LIKE @parm1
	ORDER BY ContactId
