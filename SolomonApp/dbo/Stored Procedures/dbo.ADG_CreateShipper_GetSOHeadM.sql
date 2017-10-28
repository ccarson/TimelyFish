 create proc ADG_CreateShipper_GetSOHeadM
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15)
as
	select	*
	from	SOHeaderMark

	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr


