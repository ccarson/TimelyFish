 create proc ADG_SOShipHeader_ReadMatch
	@CpnyID			varchar(10),
	@ordnbr			varchar(15),
	@siteid			varchar(10),
	@shipviaid		varchar(15),
	@shiptotype		varchar(1),
	@shiptoid		varchar(10),
	@shipcustid		varchar(15),
	@shipsiteid		varchar(10),
	@shipvendid		varchar(15),
	@shipaddrid		varchar(10),
	@weekenddelivery	smallint,
	@MarkFor		smallint,
	@DropShip		smallint
as
	select	*
	from	SOShipHeader
	where	CpnyID		= @CpnyID
	  and	OrdNbr		= @ordnbr
	  and	OKToAppend	= 1
	  and	SiteID		= @siteid
	  and	ShipViaID	= @shipviaid
	  and	ShiptoType	= @shiptotype
	  and	ShiptoID	= @shiptoid
	  and	ShipCustID	= @shipcustid
	  and	ShipSiteID	= @shipsiteid
	  and	ShipVendID	= @shipvendid
	  and	ShipAddrID	= @shipaddrid
	  and	WeekendDelivery	= @weekenddelivery
	  and	MarkFor		= @MarkFor
	  and	Status		= 'O'
	  and	DropShip	= @DropShip

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


