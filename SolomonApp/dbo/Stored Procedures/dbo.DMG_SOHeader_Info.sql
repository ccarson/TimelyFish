 create procedure DMG_SOHeader_Info
	@SOOrdNbr	varchar(15),
	@CustID		varchar(60) OUTPUT,
	@ShipCUstID	varchar(15) OUTPUT,
	@SOType		varchar(4) OUTPUT,
	@ShipToID	varchar(10) OUTPUT,
	@ShipViaID	varchar(15) OUTPUT

as

	--Initialize all the output parameters
	set @CustID = ''
	set @ShipCustID = ''
	set @SOType = ''
	set @ShipToID = ''
	set @ShipViaID = ''

	select @CustID = ltrim(rtrim(CustID)),
	       @ShipCustID = ltrim(rtrim(ShipCustID)),
	       @ShipTOID = ltrim(rtrim(ShipToID)),
	       @ShipViaID = ltrim(rtrim(ShipViaID)),
	       @SOType = ltrim(rtrim(SOTypeID)) 
	 from
		SOHeader where OrdNbr = RTrim(@SOOrdNbr)

	if @CustID = '' begin
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOHeader_Info] TO [MSDSL]
    AS [dbo];

