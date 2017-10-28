 create procedure RQFutDetProjLoad
	@parm1 varchar(10), @parm2 varchar(16), @parm3 varchar(2)
as
	select * from RQitemreqdet where
	itemReqnbr = @parm1 and
	Project = @parm2 and
	status = 'SA' and
	AppvLevReq >= @parm3
	ORDER BY ItemReqNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQFutDetProjLoad] TO [MSDSL]
    AS [dbo];

