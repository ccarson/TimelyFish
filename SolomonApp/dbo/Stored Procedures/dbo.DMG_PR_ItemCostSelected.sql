 create procedure DMG_PR_ItemCostSelected
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@RcptNbr	varchar(10),
	@Qty		decimal(25,9) OUTPUT,
	@RcptDate	smalldatetime OUTPUT,
	@TotCost	decimal(25,9) OUTPUT,
	@UnitCost	decimal(25,9) OUTPUT
as
	select	@Qty = Qty,
		@RcptDate = RcptDate,
		@TotCost = TotCost,
		@UnitCost = UnitCost
	from	ItemCost (NOLOCK)
	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	RcptNbr = @RcptNbr

	if @@ROWCOUNT = 0 begin
		set @Qty = 0
		set @RcptDate = cast('1/1/1900' as smalldatetime)
		set @TotCost = 0
		set @UnitCost = 0
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PR_ItemCostSelected] TO [MSDSL]
    AS [dbo];

