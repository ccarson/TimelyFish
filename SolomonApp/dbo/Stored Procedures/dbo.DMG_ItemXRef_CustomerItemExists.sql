 create procedure DMG_ItemXRef_CustomerItemExists
	@InvtID		varchar(30),
	@EntityID	varchar(15)
as
	if (
	select	count(*)
	from 	ItemXRef (NOLOCK)
	where	InvtID = @InvtID
	and	EntityID = @EntityID
	and	AltIDType = 'C'
	) = 0
 		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ItemXRef_CustomerItemExists] TO [MSDSL]
    AS [dbo];

