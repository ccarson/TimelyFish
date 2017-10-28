 create proc ADG_SOType_Descr
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
as
	select	Descr
	from	SOType (nolock)
	where	CpnyID = @CpnyID
	  and	SOTypeID = @SOTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOType_Descr] TO [MSDSL]
    AS [dbo];

