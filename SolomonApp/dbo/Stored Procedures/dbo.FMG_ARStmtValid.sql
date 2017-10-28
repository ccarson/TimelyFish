 create procedure FMG_ARStmtValid
	@StmtCycleId	varchar(2)
as
	if (
	select	count(*)
	from	ARStmt (NOLOCK)
	where	StmtCycleId = @StmtCycleId
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success


