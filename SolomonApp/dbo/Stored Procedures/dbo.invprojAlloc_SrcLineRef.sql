CREATE PROCEDURE invprojAlloc_SrcLineRef
	@parm1 varchar( 3 ),
	@parm2 varchar( 15 ),
    @parm3 varchar ( 5 ),
    @Parm4 varchar (  30 )
AS
	SELECT *
	FROM InvProjalloc
	WHERE SrcType = @parm1
	   AND Srcnbr = @parm2
       AND SrcLineRef = @Parm3
       And Invtid = @Parm4


GO
GRANT CONTROL
    ON OBJECT::[dbo].[invprojAlloc_SrcLineRef] TO [MSDSL]
    AS [dbo];

