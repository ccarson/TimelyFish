 create proc ADG_SOType_OrderTypeProperties
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
as
	select	AutoReleaseReturns,
		Behavior,
		Descr,
		NoAutoCreateShippers

	from	SOType (nolock)

	where	CpnyID = @CpnyID
	and	SOTypeID = @SOTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOType_OrderTypeProperties] TO [MSDSL]
    AS [dbo];

