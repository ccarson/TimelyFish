CREATE PROCEDURE pXU010InterCoClass_ClassID
	-- CREATED BY: TJones
	-- CREATED ON: 6/06/05
	@parm1 varchar(10)
	AS
	SELECT *
	FROM cftInterCoClass 
	WHERE ClassID = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXU010InterCoClass_ClassID] TO [MSDSL]
    AS [dbo];

