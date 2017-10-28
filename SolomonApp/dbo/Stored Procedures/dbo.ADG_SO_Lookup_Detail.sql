 CREATE PROCEDURE ADG_SO_Lookup_Detail
	@CpnyID varchar(10),
	@CustID varchar(15),
	@CustOrdNbr varchar(25),
	@Status varchar(1),
	@LineStatus varchar(1),
	@InvtID varchar(30),
	@SiteID varchar(10),
	@InvcNbr varchar(10),
	@OrdDateFrom varchar(10),
	@OrdDateTo varchar(10)
AS
	DECLARE	@sql 	VARCHAR(8000),
		@wherestr VARCHAR(3000)

	SELECT @wherestr = ' WHERE '

	IF PATINDEX('%[%]%', @CpnyID) = 0 -- @CpnyID <> '%'
		SELECT @wherestr = @wherestr + ' SOHeader.CpnyID = ' + QUOTENAME(@CpnyID, '''')
	ELSE
		SELECT @wherestr = @wherestr + ' SOHeader.CpnyID LIKE ' + QUOTENAME(@CpnyID, '''')
 	IF PATINDEX('%[%]%', @CustID) = 0 -- @CustID <> '%'
		SELECT @wherestr = @wherestr + ' AND SOHeader.CustID = ' + QUOTENAME(@CustID, '''')
	ELSE
		SELECT @wherestr = @wherestr + ' AND SOHeader.CustID LIKE ' + QUOTENAME(@CustID, '''')

	IF PATINDEX('%[%]%', @CustOrdNbr) = 0 -- @custordnbr <> '%'
		SELECT @wherestr = @wherestr + ' AND SOHeader.CustOrdNbr = ' + QUOTENAME(@CustOrdNbr, '''')
	ELSE
		SELECT @wherestr = @wherestr + ' AND SOHeader.CustOrdNbr LIKE ' + QUOTENAME(@CustOrdNbr, '''')
 	IF PATINDEX('%[%]%', @Status) = 0 -- @status <> '%'
		SELECT @wherestr = @wherestr + ' AND SOHeader.Status = ' + QUOTENAME(@Status, '''')
	ELSE
		SELECT @wherestr = @wherestr + ' AND SOHeader.Status LIKE ' + QUOTENAME(@Status, '''')
 	IF @LineStatus <> '%'
		SELECT @wherestr = @wherestr + ' AND SOLine.Status = ' + QUOTENAME(@LineStatus, '''') + ' AND SOSched.Status = ' + QUOTENAME(@LineStatus, '''')

	IF PATINDEX('%[%]%', @InvtID) = 0 -- @invtid  <> '%'
		SELECT @wherestr = @wherestr + ' AND SOLine.InvtID = ' + QUOTENAME(@InvtID, '''')
	ELSE
		SELECT @wherestr = @wherestr + ' AND SOLine.InvtID LIKE ' + QUOTENAME(@InvtID, '''')
 	IF PATINDEX('%[%]%', @SiteID) = 0 -- @siteid  <> '%'
		SELECT @wherestr = @wherestr + ' AND SOLine.SiteID = ' + QUOTENAME(@SiteID, '''')
	ELSE
		SELECT @wherestr = @wherestr + ' AND SOLine.SiteID LIKE ' + QUOTENAME(@SiteID, '''')
 	SELECT @wherestr = @wherestr + ' AND SOHeader.OrdDate >= ' + QUOTENAME(@OrdDateFrom,'''')
	SELECT @wherestr = @wherestr + ' AND SOHeader.OrdDate <= ' + QUOTENAME(@OrdDateTo,'''')

	-- We need to have two queries because LIKE % will limit
	-- records when referencing SOShipHeader and there is no
	-- matching record in the join. A NULL would be returned
	-- for InvcNbr and NULL is always not like anything.
	IF @InvcNbr = '%'
	BEGIN
		SELECT @sql = '
			SELECT	SOSched.*,
				SOHeader.CustID,
				SOLine.InvtID,
				SOLine.Descr,
				SOHeader.ShipName,
				SOLine.UnitDesc,
				SOHeader.Status
			FROM SOSched WITH (NOLOCK)
			  LEFT JOIN SOHeader WITH (NOLOCK) ON SOHeader.CpnyID = SOSched.CpnyID AND SOHeader.OrdNbr = SOSched.OrdNbr
			  LEFT JOIN SOLine WITH (NOLOCK) ON SOLine.CpnyID = SOSched.CpnyID AND SOLine.OrdNbr = SOSched.OrdNbr AND SOLine.LineRef = SOSched.LineRef '
			+ @wherestr + ' ORDER BY SOSched.OrdNbr'
	END
	ELSE
	BEGIN
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.InvcNbr LIKE ' + QUOTENAME(@InvcNbr, '''')
		SELECT @sql = '
				SELECT	SOSched.*,
				SOHeader.CustID,
				SOLine.InvtID,
				SOLine.Descr,
				SOHeader.ShipName,
				SOLine.UnitDesc,
				SOHeader.Status
			FROM SOSched WITH (NOLOCK)
			  LEFT JOIN SOHeader WITH (NOLOCK) ON SOHeader.CpnyID = SOSched.CpnyID AND SOHeader.OrdNbr = SOSched.OrdNbr
			  LEFT JOIN SOLine WITH (NOLOCK) ON SOLine.CpnyID = SOSched.CpnyID AND SOLine.OrdNbr = SOSched.OrdNbr AND SOLine.LineRef = SOSched.LineRef
			  LEFT JOIN SOShipHeader WITH (NOLOCK) ON SOShipHeader.CpnyID = SOSched.CpnyID AND SOShipHeader.OrdNbr = SOSched.OrdNbr  '
			+ @wherestr + ' ORDER BY SOSched.OrdNbr'
	END

	EXEC (@sql)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SO_Lookup_Detail] TO [MSDSL]
    AS [dbo];

