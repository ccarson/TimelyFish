 CREATE PROCEDURE DMG_SOType_Plus
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
AS
	select	*
	from	SOType
	where	CpnyID LIKE @CpnyID
	and	SOTypeID LIKE @SOTypeID
	order by CpnyID, SOTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOType_Plus] TO [MSDSL]
    AS [dbo];

