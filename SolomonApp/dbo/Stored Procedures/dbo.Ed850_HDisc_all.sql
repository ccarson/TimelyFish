 CREATE PROCEDURE Ed850_HDisc_all
 @parm1 varchar( 10 ), @parm2 varchar(10),
 @parm2min smallint, @parm2max smallint
AS
 SELECT *
 FROM Ed850HDisc
 WHERE cpnyid = @parm1 and EdiPoId LIKE @parm2
    AND LineNbr BETWEEN @parm2min AND @parm2max
 ORDER BY EdiPoId,
    LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Ed850_HDisc_all] TO [MSDSL]
    AS [dbo];

