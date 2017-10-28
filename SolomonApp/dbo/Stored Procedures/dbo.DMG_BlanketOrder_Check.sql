 create procedure DMG_BlanketOrder_Check
	@CpnyID		varchar(10),	-- Company ID
	@OrdNbr		varchar(15)	-- Child Sales Order Number
as
	set nocount on

	-- get blanket order number and cancelled status for this order - only consider
	-- order type behaviors of Counter Sale, Sales Order, and Will Call, and RMA, and MO, and INVC
	select	H.BlktOrdNbr, H.Cancelled
	from	SOHeader H join SOType T on
		H.CpnyID = T.CpnyID and
		H.SOTypeID = T.SOTypeID
	where	H.CpnyID = @CpnyID
	and	H.OrdNbr = @OrdNbr
	and	T.Behavior in ('CS', 'SO', 'WC', 'RMA', 'MO', 'INVC')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_BlanketOrder_Check] TO [MSDSL]
    AS [dbo];

