 CREATE PROCEDURE ADG_SOPrintQueue_UpdateInvoice
	@CpnyID 	varchar(10),
	@RI_ID 		smallint,
	@ShipperID 	varchar(15),
	@InvcNbr 	varchar(15)

AS
	Declare @CurrentInvcNbr	varchar(15)
		-- Make sure that an Invoice number has not already been written in this field.
	select	@CurrentInvcNbr = InvcNbr
	from	SOPrintQueue
	Where	CpnyID = @CpnyID
	  and	RI_ID = @RI_ID
	  and	ShipperID = @ShipperID

	If RTrim(@CurrentInvcNbr) = ''
	begin
		update 	SOPrintQueue
		Set	InvcNbr = @InvcNbr
		Where	CpnyID = @CpnyID
		  and	RI_ID = @RI_ID
		  and	ShipperID = @ShipperID

		select  @InvcNbr
	end
	else
		select 	@CurrentInvcNbr
	-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


