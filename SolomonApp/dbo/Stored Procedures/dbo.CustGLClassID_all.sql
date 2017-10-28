 CREATE PROCEDURE CustGLClassID_all
	@parm1 varchar(10)
AS
	SELECT *
	FROM CustGLClass
	WHERE s4future11 LIKE @parm1
	ORDER BY s4future11


