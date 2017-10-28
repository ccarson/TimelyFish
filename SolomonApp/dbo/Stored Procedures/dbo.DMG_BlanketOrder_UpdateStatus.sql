 create procedure DMG_BlanketOrder_UpdateStatus
	@CpnyID		varchar(10),	-- Company ID
	@BlktOrdNbr	varchar(15)	-- Blanket Order Number
as
	set nocount on

	update	SOSched
	set	Status = case 	when (QtyOrd - QtyShip) < power(convert(float,0.1), DecPlNonStdQty)/2 then 'C'
				else 'O' end
	from	SOSched
	cross 	join SOSetup (nolock)
	where	CpnyID = @CpnyID
	and	OrdNbr = @BlktOrdNbr

	update	SOLine
	set	Status = case when MinStatus = MaxStatus then MinStatus else 'P' end
	from	SOLine
	inner	join (select OrdNbr, LineRef, MaxStatus = max(Status), MinStatus = min(Status) from SOSched v group by OrdNbr, LineRef) v on v.OrdNbr = SOLine.OrdNbr and v.LineRef = SOLine.LineRef
	where	SOLine.CpnyID = @CpnyID
	and	SOLine.OrdNbr = @BlktOrdNbr

	update	SOHeader
	set	Status = case when exists(select * from SOLine where OrdNbr = SOHeader.OrdNbr and Status IN ('O', 'P')) then 'O' else 'C' end
	where	CpnyID = @CpnyID
	and	OrdNbr = @BlktOrdNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_BlanketOrder_UpdateStatus] TO [MSDSL]
    AS [dbo];

