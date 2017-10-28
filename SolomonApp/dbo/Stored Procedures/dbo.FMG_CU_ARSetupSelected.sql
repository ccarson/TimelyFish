 create procedure FMG_CU_ARSetupSelected
	@ARAcct		varchar(10) OUTPUT,
	@ARSub		varchar(24) OUTPUT,
	@CurrPerNbr	varchar(6) OUTPUT,
	@DfltAutoApply	smallint OUTPUT,
	@DfltClass	varchar(6) OUTPUT,
	@DfltStmtCycle	varchar(2) OUTPUT,
	@DfltStmtType	varchar(1) OUTPUT,
	@IncAcct	varchar(10) OUTPUT,
	@IncSub		varchar(24) OUTPUT,
	@PerNbr		varchar(6) OUTPUT,
	@PrePayAcct	varchar(10) OUTPUT,
	@PrePaySub	varchar(24) OUTPUT,
	@S4Future11	varchar(10) OUTPUT
as
	select	@ARAcct = ltrim(rtrim(ARAcct)),
		@ARSub = ltrim(rtrim(ARSub)),
		@CurrPerNbr = ltrim(rtrim(CurrPerNbr)),
		@DfltAutoApply = DfltAutoApply,
		@DfltClass = ltrim(rtrim(DfltClass)),
		@DfltStmtCycle = ltrim(rtrim(DfltStmtCycle)),
		@DfltStmtType = ltrim(rtrim(DfltStmtType)),
		@IncAcct = ltrim(rtrim(IncAcct)),
		@IncSub = ltrim(rtrim(IncSub)),
		@PerNbr = ltrim(rtrim(PerNbr)),
		@PrePayAcct = ltrim(rtrim(PrePayAcct)),
		@PrePaySub = ltrim(rtrim(PrePaySub)),
		@S4Future11 = ltrim(rtrim(S4Future11))
	from	ARSetup (NOLOCK)

	if @@ROWCOUNT = 0
		return 0	--Failure
	else
		return 1	--Success


