CREATE PROCEDURE CF341p_cfvSite_ContactId @parm1 varchar (6) 
	as 
	SELECT * FROM cfvSite 
	WHERE ContactId Like @parm1
	ORDER BY ContactId
