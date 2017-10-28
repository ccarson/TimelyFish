 CREATE PROCEDURE EDCurrency_all
 @parm1 varchar( 10 ),
 @parm2 varchar( 10 )
AS
 SELECT *
 FROM EDCurrency
 WHERE CuryId LIKE @parm1
    AND EDCuryId LIKE @parm2
 ORDER BY CuryId,
    EDCuryId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDCurrency_all] TO [MSDSL]
    AS [dbo];

