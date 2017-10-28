CREATE PROCEDURE XS015p_InterCoClass_ClassID
	@parm1 varchar(10)
	AS
	SELECT * 
	FROM cftInterCoClass c
	JOIN ProductClass p on c.ClassID = p.ClassID
	WHERE c.ClassID LIKE @parm1
	ORDER BY c.ClassID
