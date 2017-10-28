CREATE PROCEDURE pXU015InterCoClass_ClassID
	------------------------------------------------------------
	-- CREATED BY: TJones
	-- CREATED ON: 8/19/05
	-- USED BY: XU015
	------------------------------------------------------------
	@parm1 varchar(10)
	AS
	SELECT * 
	FROM cftInterCoClass c
	JOIN ProductClass p on c.ClassID = p.ClassID
	WHERE c.ClassID LIKE @parm1
	ORDER BY c.ClassID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXU015InterCoClass_ClassID] TO [MSDSL]
    AS [dbo];

