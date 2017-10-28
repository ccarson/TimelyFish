 create proc ADG_CreateShipper_LineConv
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5)
as
	select	CnvFact,
		UnitMultDiv

	from	SOLine

	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr
	  and	LineRef = @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_CreateShipper_LineConv] TO [MSDSL]
    AS [dbo];

