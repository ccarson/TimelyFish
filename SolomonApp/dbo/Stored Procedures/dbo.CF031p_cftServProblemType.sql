create procedure CF031p_cftServProblemType
        @parm1 varchar(5)
	as
	select * from cftServProblemType
        where ProblemTypeID like @parm1
	order by ProblemTypeID
