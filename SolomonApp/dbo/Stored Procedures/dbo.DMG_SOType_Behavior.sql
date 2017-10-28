 create proc DMG_SOType_Behavior
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4),
	@Behavior	varchar(4) OUTPUT
as
	select	@Behavior = ltrim(rtrim(Behavior))
	from	SOType (NOLOCK)
	where	CpnyID = @CpnyID
	and	SOTypeID = @SOTypeID

	if @@ROWCOUNT = 0 begin
		set @Behavior = ''
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOType_Behavior] TO [MSDSL]
    AS [dbo];

