 CREATE PROCEDURE DMG_SOType_Standard
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
AS
	select	*
	from	SOType
	where	CpnyID LIKE @CpnyID
	and	SOTypeID LIKE @SOTypeID
	and	SOTypeID IN ('BL', 'CM', 'DM', 'INVC', 'Q', 'RFC', 'SO')
	order by CpnyID, SOTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOType_Standard] TO [MSDSL]
    AS [dbo];

