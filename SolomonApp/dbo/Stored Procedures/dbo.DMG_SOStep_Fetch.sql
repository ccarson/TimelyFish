 create procedure DMG_SOStep_Fetch
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
as
	select	*
	from	SOStep
	where	CpnyID = @CpnyID
	and	SOTypeID = @SOTypeID


