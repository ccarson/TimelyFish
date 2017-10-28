 create procedure DMG_PO_POSetupSelected
	@AddAlternateID		varchar(1) OUTPUT,
	@DecPlPrcCst		smallint OUTPUT,
	@DecPlQty		smallint OUTPUT,
	@DfltLstUnitCost	varchar(1) OUTPUT,
	@FrtAcct		varchar(10) OUTPUT,
	@FrtSub			varchar(30) OUTPUT,
	@NonInvtAcct		varchar(10) OUTPUT,
	@NonInvtSub		varchar(24) OUTPUT
as
	select	@AddAlternateID = ltrim(rtrim(AddAlternateID)),
		@DecPlPrcCst = DecPlPrcCst,
		@DecPlQty = DecPlQty,
		@DfltLstUnitCost = ltrim(rtrim(DfltLstUnitCost)),
		@FrtAcct = ltrim(rtrim(S4Future11)),
		@FrtSub = ltrim(rtrim(S4Future01)),
		@NonInvtAcct = ltrim(rtrim(NonInvtAcct)),
		@NonInvtSub = ltrim(rtrim(NonInvtSub))
	from	POSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @AddAlternateID = ''
		set @DecPlPrcCst = 0
		set @DecPlQty = 0
		set @DfltLstUnitCost = ''
		set @FrtAcct = ''
		set @FrtSub = ''
		set @NonInvtAcct = ''
		set @NonInvtSub = ''
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_POSetupSelected] TO [MSDSL]
    AS [dbo];

