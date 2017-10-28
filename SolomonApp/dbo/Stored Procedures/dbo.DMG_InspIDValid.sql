 create procedure DMG_InspIDValid
	@InvtID	varchar(30),
	@InspID	varchar(2)
as
	if (
	select	count(*)
	from	Inspection (NOLOCK)
	where	InvtID = @InvtID
	and	InspID = @InspID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_InspIDValid] TO [MSDSL]
    AS [dbo];

