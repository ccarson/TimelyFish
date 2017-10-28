 CREATE PROCEDURE Ed850_LineItem_all
 @parm1 varchar( 10 ),
 @parm2min smallint, @parm2max smallint
AS
 SELECT *
 FROM Ed850LineItem
 WHERE EDIPoId LIKE @parm1
    AND LineNbr BETWEEN @parm2min AND @parm2max
 ORDER BY EDIPoId,
    LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Ed850_LineItem_all] TO [MSDSL]
    AS [dbo];

