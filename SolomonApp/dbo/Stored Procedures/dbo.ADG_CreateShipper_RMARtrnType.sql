 create proc ADG_CreateShipper_RMARtrnType
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
as
	select	ReturnOrderTypeID
	from	SOType
	where	CpnyID = @CpnyID
	  and	SOTypeID = @SOTypeID


