 create procedure DMG_PR_POSetupSelected
	@CreateAD		smallint OUTPUT,
	@DecPlPrcCst		smallint OUTPUT,
	@DecPlQty		smallint OUTPUT,
	@DfltLstUnitCost	varchar(1) OUTPUT,
	@DfltRcptUnitFromIN	smallint OUTPUT,
	@FrtAcct		varchar(10) OUTPUT,
	@FrtSub			varchar(24) OUTPUT,
	@NonInvtAcct		varchar(10) OUTPUT,
	@NonInvtSub		varchar(24) OUTPUT,
	@ReopenPO		smallint OUTPUT,
	@MultPOAllowed		smallint OUTPUT
as
	select	@CreateAD = CreateAD,
		@DecPlPrcCst = DecPlPrcCst,
		@DecPlQty = DecPlQty,
		@DfltLstUnitCost = ltrim(rtrim(DfltLstUnitCost)),
		@DfltRcptUnitFromIN = DfltRcptUnitFromIN,
		@FrtAcct = ltrim(rtrim(S4Future11)),
		@FrtSub = ltrim(rtrim(S4Future01)),
		@NonInvtAcct = ltrim(rtrim(NonInvtAcct)),
		@NonInvtSub = ltrim(rtrim(NonInvtSub)),
		@ReopenPO = ReopenPO,
		@MultPOAllowed = MultPOAllowed
	from	POSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @CreateAD = 0
		set @DecPlPrcCst = 0
		set @DecPlQty = 0
		set @DfltRcptUnitFromIN = 0
		set @FrtAcct = ''
		set @FrtSub = ''
		set @NonInvtAcct = ''
		set @NonInvtSub = ''
		set @ReopenPO = 0
		set @MultPOAllowed = 0
		return 0	--Failure
	end
	else
		return 1	--Success


