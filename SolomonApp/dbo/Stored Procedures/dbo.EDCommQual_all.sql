 CREATE PROCEDURE EDCommQual_all
 @parm1 varchar( 2 )
AS
 SELECT *
 FROM EDCommQual
 WHERE CommID LIKE @parm1
 ORDER BY CommID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDCommQual_all] TO [MSDSL]
    AS [dbo];

