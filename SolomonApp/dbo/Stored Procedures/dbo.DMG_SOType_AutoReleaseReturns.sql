 create proc DMG_SOType_AutoReleaseReturns
	@CpnyID			varchar(10),
	@SOTypeID		varchar(4),
	@AutoReleaseReturns	smallint OUTPUT
as
	select	@AutoReleaseReturns = AutoReleaseReturns
	from	SOType (NOLOCK)
	where	CpnyID = @CpnyID
	and	SOTypeID = @SOTypeID

	if @@ROWCOUNT = 0 begin
		set @AutoReleaseReturns = 0
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOType_AutoReleaseReturns] TO [MSDSL]
    AS [dbo];

