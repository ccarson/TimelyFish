 Create Procedure EDShipment_SOShipHeaderSrch
	@CustID VarChar(15),
	@ShiptoID VarChar(10),
	@CustOrdNbr VarChar(25),
	@OrdNbr VarChar(15),
	@ShipDateBegin SmallDateTime,
	@ShipDateEnd SmallDateTime,
	@ShipViaID VarChar(17)
AS

declare
	@WhereStr varchar(8000)

select
	@wherestr = '',
	@CustID = NULLIF(NULLIF(@CustID,''), '%'),
	@ShiptoID = NULLIF(NULLIF(@ShiptoID,''), '%'),
	@CustOrdNbr = NULLIF(NULLIF(@CustOrdNbr,''), '%'),
	@OrdNbr = NULLIF(NULLIF(@OrdNbr,''), '%'),
	@ShipDateBegin = NULLIF(@ShipDateBegin,'01/01/1900'),
	@ShipDateEnd = NULLIF(@ShipDateEnd,'01/01/1900'),
	@ShipViaID = QUOTENAME(@ShipViaID,'''')

if @CustID is not null
	select @wherestr = @wherestr + ' AND CustID LIKE ' + QUOTENAME(@CustID,'''')

if @ShipToID is not null
	select @wherestr = @wherestr + ' AND ShipToID LIKE ' + QUOTENAME(@ShipToID,'''')

if @CustOrdNbr is not null
	select @wherestr = @wherestr + ' AND CustOrdNbr LIKE ' + QUOTENAME(@CustOrdNbr,'''')

if @OrdNbr is not null
	select @wherestr = @wherestr + ' AND OrdNbr LIKE ' + QUOTENAME(@OrdNbr,'''')

if @ShipDateBegin is not null or @ShipDateEnd is not null
	select @wherestr = @wherestr +
			' AND ShipDateAct BETWEEN ' + QUOTENAME(ISNULL(@ShipDateBegin, '01/01/1900'),'''') +
			' AND ' + QUOTENAME(ISNULL(@ShipDateEnd, '01/01/2079'),'''')

exec('SELECT * FROM SOShipHeader (nolock) WHERE Cancelled = 0' + @wherestr +
'	AND	(
			Status <> ''C'' Or
			ShipViaID = ' + @ShipViaID + '
		)
	AND NOT EXISTS
		(
			Select
				*
			From
				EDShipTicket (nolock)
				Inner Join EDShipment (nolock) On
					EDShipment.BOLNbr = EDShipTicket.BOLNbr
			Where
				EDShipTicket.ShipperID = SOShipHeader.ShipperID
				And EDShipTicket.CpnyID = SOShipHeader.CpnyID
				And EDShipment.ShipStatus = ''C''
		)
ORDER BY
	CpnyID,
	ShipperID
')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_SOShipHeaderSrch] TO [MSDSL]
    AS [dbo];

