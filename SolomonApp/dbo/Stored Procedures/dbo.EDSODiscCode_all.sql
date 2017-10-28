 CREATE PROCEDURE EDSODiscCode_all
 @parm1 varchar( 10 ),
 @parm2 varchar( 1 )
AS
 SELECT *
 FROM EDSODiscCode
 WHERE CpnyId LIKE @parm1
    AND DiscountID LIKE @parm2
 ORDER BY CpnyId,
    DiscountID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSODiscCode_all] TO [MSDSL]
    AS [dbo];

