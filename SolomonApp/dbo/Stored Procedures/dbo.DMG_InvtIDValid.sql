 create procedure DMG_InvtIDValid
	@InvtID	varchar(30)
as
	declare	@Count smallint

	select	@Count = count(*)
		from	Inventory (NOLOCK)
		where	InvtID = @InvtID

	--select @Count

	if @Count = 0
		return 0	--Failure
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_InvtIDValid] TO [MSDSL]
    AS [dbo];

