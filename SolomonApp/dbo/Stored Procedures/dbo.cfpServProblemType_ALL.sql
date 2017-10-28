create procedure cfpServProblemType_ALL
	@parm1 varchar(5)
	as
	select * from cftServProblemType
	order by ProblemTypeID
