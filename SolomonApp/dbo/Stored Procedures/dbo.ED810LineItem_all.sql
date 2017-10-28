 CREATE PROCEDURE ED810LineItem_all
 @parm1 varchar( 10 ),
 @parm2min smallint, @parm2max smallint
AS
 SELECT *
 FROM ED810LineItem
 WHERE EDIInvId LIKE @parm1
    AND LineNbr BETWEEN @parm2min AND @parm2max
 ORDER BY EDIInvId,
    LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810LineItem_all] TO [MSDSL]
    AS [dbo];

