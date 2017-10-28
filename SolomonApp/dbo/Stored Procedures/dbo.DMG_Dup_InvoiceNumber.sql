 create procedure DMG_Dup_InvoiceNumber

	@InvoiceNumber varchar(15),
	@OrdNbr varchar(15),
	@ShipperID varchar(15)
as

	declare @DupOrdNbr varchar(15)
	declare @DupShipperID varchar(15)

	select 	@DupOrdNbr = '', @DupShipperID = ''

	select	@DupOrdNbr = OrdNbr
	from	SOHeader
	where	InvcNbr = @InvoiceNumber
	and	OrdNbr <> @OrdNbr

	select	@DupShipperID = ShipperID
	from	SOShipHeader
	where	InvcNbr = @InvoiceNumber
	and	ShipperID <> @ShipperID

	select @DupOrdNbr, @DupShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Dup_InvoiceNumber] TO [MSDSL]
    AS [dbo];

