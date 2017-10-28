 create procedure DMG_PO_SOLine_BoundToWO
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@BoundToWO	smallint OUTPUT
as
	select	@BoundToWO = BoundToWO
	from	SOLine (NOLOCK)
	where	CpnyID = @CpnyID
	and	OrdNbr = @OrdNbr
	and	LineRef = @LineRef

	if @@ROWCOUNT = 0 begin
		set @BoundToWO = 0
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_SOLine_BoundToWO] TO [MSDSL]
    AS [dbo];

