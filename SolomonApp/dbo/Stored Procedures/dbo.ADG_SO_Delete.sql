 CREATE PROCEDURE ADG_SO_Delete

	@CpnyID		varchar(10),
	@DelDate	varchar(10),
	@BookDelPeriod	varchar(6),
	@User		varchar(10)
AS
	Declare @cCpnyID		varchar(10)
	Declare @cOrdNbr		varchar(15)

	-- delete SOHeader records that were last updated before the deletion date and are closed
	delete	from SOHeader
	where	LUpd_DateTime < @DelDate
	  and	CpnyID = @CpnyID
	  and	Status = 'C'

	-- delete SOShipHeader records that have an order number and the order record doesn't exist
	delete	from SOShipHeader
	where	CpnyID = @CpnyID
	  and	OrdNbr <> ''
	  and	OrdNbr not in (select OrdNbr from SOHeader where CpnyID = @CpnyID)

	-- delete SOShipHeader records that were last updated before the deletion date and are closed
	-- and don't have an order number
	delete	from SOShipHeader
	where	LUpd_DateTime < @DelDate
	  and	CpnyID = @CpnyID
	  and	Status = 'C'
	  and	OrdNbr = ''

	-- Delete Book records where the effective period is before the cut-off period.
	delete	from Book
	where	CpnyID = @CpnyID
	  and	EffPeriod < @BookDelPeriod

	-- delete all orphaned order and shipper sub-table records
	execute ADG_SO_Delete_Orphans @CpnyID

	-- Set the orders to closed for expired quotes.
	Declare CsrHeader cursor for
	Select 	h.CpnyID, h.OrdNbr
	from 	soheader h
		inner join sotype t on h.CpnyID = t.CpnyID and h.SOTypeID = t.SOTypeID
	Where 	h.Status = 'O'
	  and 	t.Behavior = 'Q'
	  and 	h.NextFunctionID = '4010000'
	  and 	h.NextFunctionClass = '9999'
	  and 	h.CancelDate < GetDate()

	Open CsrHeader
		fetch next from CsrHeader into @cCpnyID, @cOrdNbr

	while (@@fetch_status = 0)
	begin
		update 	SOHeader
		Set	Status = 'C',
			NextFunctionID = '',
			NextFunctionClass = '',
			LUpd_DateTime = GetDate(),
			LUpd_Prog = '40490',
			LUpd_User = @User
		Where	CpnyID = @cCpnyID
		  and	OrdNbr = @cOrdNbr

		execute ADG_SOEvent_Create @cCpnyID, '', 'CLOR', @cOrdNbr, '40490', '', @User

		fetch next from CsrHeader into @cCpnyID, @cOrdNbr

	end

	close CsrHeader
	deallocate CsrHeader

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SO_Delete] TO [MSDSL]
    AS [dbo];

