 create procedure DMG_UOMValid
	@ClassID	varchar(6),
	@StkUnit	varchar(6),
	@InvtID		varchar(30),
	@UOM		varchar(6)
as
	if (
	select	count(*)
	from	INUnit (NOLOCK)
	where	FromUnit = @UOM
	and	ToUnit = @StkUnit
	and	(InvtId = '*' or InvtId = @InvtID)
	and	(ClassId = '*' or ClassId = @ClassID)
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success


