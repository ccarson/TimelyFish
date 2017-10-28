 CREATE PROCEDURE RQreqdet_LineNbr_All @parm1 Varchar(10), @parm2 Varchar(2), @parm3min SmallInt, @parm3max SmallInt AS
SELECT * FROM RQreqdet
WHERE ReqNbr = @parm1 and
ReqCntr = @Parm2 and
LineNbr BETWEEN @parm3min AND @parm3max
ORDER BY ReqNbr, ReqCntr, LineNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQreqdet_LineNbr_All] TO [MSDSL]
    AS [dbo];

