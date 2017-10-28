 create procedure DMG_PR_Location_By_WhseLoc_InvtID_Exists
	@WhseLoc		varchar(10),
	@InvtID			varchar(30),
	@WhseLocExists		smallint OUTPUT,
	@WhseLocInvtIDExists	smallint OUTPUT
as
	-- Check whether any Location records exist that match
	-- the warehouse bin location only
	if (
	select	count(*)
	from 	Location (NOLOCK)
	where	WhseLoc = @WhseLoc
 	) = 0
		set @WhseLocExists = 0
	else
		set @WhseLocExists = -1

	-- Check whether any Location records exist that match
	-- the warehouse bin location and inventory item
	if (
	select	count(*)
	from 	Location (NOLOCK)
	where	WhseLoc = @WhseLoc
	and	InvtID = @InvtID
 	) = 0
		set @WhseLocInvtIDExists = 0
	else
		set @WhseLocInvtIDExists = -1

	--select @WhseLocExists, @WhseLocInvtIDExists

	-- Indicate success
	return 1


