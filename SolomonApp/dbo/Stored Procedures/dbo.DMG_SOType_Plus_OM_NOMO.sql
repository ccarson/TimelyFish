 CREATE PROCEDURE DMG_SOType_Plus_OM_NOMO
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
AS
	select	*
	from	SOType
	where	CpnyID = @CpnyID
	and	SOTypeID LIKE @SOTypeID
	and Behavior <> 'MO'
	order by CpnyID, SOTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOType_Plus_OM_NOMO] TO [MSDSL]
    AS [dbo];

