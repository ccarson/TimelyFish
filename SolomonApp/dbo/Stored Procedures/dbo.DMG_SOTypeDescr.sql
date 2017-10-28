 create proc DMG_SOTypeDescr
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4),
	@Descr		varchar(30) OUTPUT
as
	select	@Descr = ltrim(rtrim(Descr))
	from	SOType (NOLOCK)
	where	CpnyID = @CpnyID
	and	SOTypeID = @SOTypeID

	if @@ROWCOUNT = 0
		return 0
	else
		return 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOTypeDescr] TO [MSDSL]
    AS [dbo];

