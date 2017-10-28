 CREATE PROCEDURE Ed850_Contact_all
 @parm1 varchar( 10 ),
 @parm2min smallint, @parm2max smallint
AS
 SELECT *
 FROM Ed850Contact
 WHERE EdiPoId LIKE @parm1
    AND LineNbr BETWEEN @parm2min AND @parm2max
 ORDER BY EdiPoId,
    LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Ed850_Contact_all] TO [MSDSL]
    AS [dbo];

