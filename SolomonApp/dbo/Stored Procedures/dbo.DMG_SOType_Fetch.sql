 create procedure DMG_SOType_Fetch
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
as
	select	*
	from	SOType
	where	CpnyID = @CpnyID
	and	SOTypeID = @SOTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOType_Fetch] TO [MSDSL]
    AS [dbo];

