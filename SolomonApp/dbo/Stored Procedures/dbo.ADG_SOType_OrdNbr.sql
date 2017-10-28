 create proc ADG_SOType_OrdNbr
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
as
	select	LastOrdNbr,
		OrdNbrPrefix,
		OrdNbrType
	from	SOType
	where	CpnyID = @CpnyID
	  and	SOTypeID = @SOTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOType_OrdNbr] TO [MSDSL]
    AS [dbo];

