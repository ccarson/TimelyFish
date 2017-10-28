 CREATE PROCEDURE ADG_SH_RMA_Lookup_Detail
	@CpnyID varchar(10),
	@CustID varchar(15),
	@CustOrdNbr varchar(25),
	@Status varchar(1),
	@InvtID varchar(30),
	@SiteID varchar(10),
	@InvcNbr varchar(10),
	@OrdNbr varchar(15),
	@OrdDateFrom varchar(10),
	@OrdDateTo varchar(10)
AS

	DECLARE	@sql 	VARCHAR(8000),
		@wherestr VARCHAR(3000)

	SELECT @wherestr = ' 1 = 1 '

	IF PATINDEX('%[%,_]%', @CpnyID) = 0 -- @CpnyID <> '%'
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.CpnyID = ' + QUOTENAME(@CpnyID, '''')
	ELSE IF @CpnyID <> '%'
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.CpnyID LIKE ' + QUOTENAME(@CpnyID, '''')
 	IF PATINDEX('%[%,_]%', @CustID) = 0 -- @CustID <> '%'
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.CustID = ' + QUOTENAME(@CustID, '''')
	ELSE IF @CustID <> '%'
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.CustID LIKE ' + QUOTENAME(@CustID, '''')

	IF PATINDEX('%[%,_]%', @CustOrdNbr) = 0 -- @custordnbr <> '%'
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.CustOrdNbr = ' + QUOTENAME(@CustOrdNbr, '''')
	ELSE IF @CustOrdNbr <> '%'
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.CustOrdNbr LIKE ' + QUOTENAME(@CustOrdNbr, '''')
 	IF PATINDEX('%[%,_]%', @Status) = 0 -- @status <> '%'
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.Status = ' + QUOTENAME(@Status, '''')
	ELSE IF @Status <> '%'
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.Status LIKE ' + QUOTENAME(@Status, '''')
 	IF PATINDEX('%[%,_]%', @SiteID) = 0 -- @siteid <> '%'
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.SiteID = ' + QUOTENAME(@SiteID, '''')
	ELSE IF @SiteID <> '%'
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.SiteID LIKE ' + QUOTENAME(@SiteID, '''')
 	IF PATINDEX('%[%,_]%', @InvcNbr) = 0 -- @invcnbr  <> '%'
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.InvcNbr = ' + QUOTENAME(@InvcNbr, '''')
	ELSE IF @InvcNbr <> '%'
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.InvcNbr LIKE ' + QUOTENAME(@InvcNbr, '''')
 	IF PATINDEX('%[%,_]%', @OrdNbr) = 0 -- @ordnbr  <> '%'
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.OrdNbr = ' + QUOTENAME(@OrdNbr, '''')
	ELSE IF @OrdNbr <> '%'
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.OrdNbr LIKE ' + QUOTENAME(@OrdNbr, '''')

	IF PATINDEX('%[%,_]%', @InvtID) = 0 -- @InvtID  <> '%'
		SELECT @wherestr = @wherestr + ' AND SOShipLine.InvtID = ' + QUOTENAME(@InvtID, '''')
	ELSE IF @InvtID <> '%'
		SELECT @wherestr = @wherestr + ' AND SOShipLine.InvtID LIKE ' + QUOTENAME(@InvtID, '''')

	IF @OrdDateFrom <> '01/01/1900'
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.OrdDate >= ' + QUOTENAME(@OrdDateFrom,'''')

	IF @OrdDateTo <> '01/01/2079'
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.OrdDate <= ' + QUOTENAME(@OrdDateTo,'''' )

	SELECT @sql = '
	select	SOShipLine.*,
		SOShipHeader.CustID,
		SOShipHeader.ShipName,
		SOShipHeader.ShipViaID,
		SOShipHeader.SiteID,
		SOShipHeader.TransitTime,
		Hold = CASE SOShipHeader.AdminHold WHEN 0 THEN SOShipHeader.CreditHold ELSE 1 END,
		SOShipHeader.WeekendDelivery,
		SOShipHeader.ShipDateAct,
		SOShipHeader.ShipDatePlan
	from	SOShipHeader (NOLOCK)
	inner join
		SOShipLine ON SOShipLine.CpnyID = SOShipHeader.CpnyID AND SOShipLine.ShipperID = SOShipHeader.ShipperID
	inner join
		Batch ON Batch.BatNbr = SOShipHeader.INBatNbr and Batch.Module = ''IN''
	join	SOType (NOLOCK) ON SOType.CpnyID = SOShipHeader.CpnyID and SOType.SOTypeID = SOShipHeader.SOTypeID
	where	' + @wherestr + '
	and	SOShipHeader.Cancelled = 0
	and	SOType.Behavior in (''CS'', ''INVC'', ''MO'', ''RMA'', ''RMSH'', ''SERV'', ''SO'', ''WC'', ''WO'')
	and SOShipLine.QtyShip > 0
	and	Batch.Rlsed = 1
		ORDER BY SOShipHeader.CpnyID, SOShipHeader.ShipperID'

	EXEC (@sql)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SH_RMA_Lookup_Detail] TO [MSDSL]
    AS [dbo];

