 CREATE PROCEDURE ADG_SO_Lookup_Summary
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
		SELECT @wherestr = @wherestr + ' AND SOLine.Status = ' + QUOTENAME(@LineStatus, '''')

	SELECT @wherestr = @wherestr + ' AND SOHeader.OrdDate >= ' + QUOTENAME(@OrdDateFrom,'''')
	SELECT @wherestr = @wherestr + ' AND SOHeader.OrdDate <= ' + QUOTENAME(@OrdDateTo,'''')

	-- User did not specify inventory ID, site or invoice number.
	IF @LineStatus = '%' AND @InvtID = '%' AND @SiteID = '%' AND @InvcNbr = '%'
	BEGIN
		SELECT @sql = '
			SELECT SOHeader.* FROM SOHeader WITH (NOLOCK) '
			+ @wherestr + ' ORDER BY SOHeader.OrdNbr'
	END

	-- User specified an invoice number.
	IF @LineStatus = '%' AND @InvtID = '%' AND @SiteID = '%' AND @InvcNbr <> '%'
	BEGIN
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.InvcNbr LIKE ' + QUOTENAME(@InvcNbr, '''')
		SELECT @sql = '
			SELECT SOHeader.* FROM SOHeader WITH (NOLOCK)
			  LEFT JOIN SOShipHeader WITH (NOLOCK) ON SOShipHeader.CpnyID = SOHeader.CpnyID AND SOShipHeader.OrdNbr = SOHeader.OrdNbr '
			+ @wherestr + ' ORDER BY SOHeader.OrdNbr'
	END

	-- User specified inventory ID or site.
	IF (@LineStatus <> '%' OR @InvtID <> '%' OR @SiteID <> '%') AND @InvcNbr = '%'
	BEGIN
		SELECT @wherestr = @wherestr + ' AND SOLine.InvtID LIKE ' + QUOTENAME(@InvtID, '''')
		SELECT @wherestr = @wherestr + ' AND SOLine.SiteID LIKE ' + QUOTENAME(@SiteID, '''')
		SELECT @sql = '
			SELECT SOHeader.* FROM SOHeader WITH (NOLOCK)
			  LEFT JOIN SOLine WITH (NOLOCK) ON SOLine.CpnyID = SOHeader.CpnyID AND SOLine.OrdNbr = SOHeader.OrdNbr '
			+ @wherestr + ' ORDER BY SOHeader.OrdNbr'
	END

	-- User specified inventory ID or site and also invoice number.
	IF (@LineStatus <> '%' OR @InvtID <> '%' OR @SiteID <> '%') AND @InvcNbr <> '%'
	BEGIN
		SELECT @wherestr = @wherestr + ' AND SOShipHeader.InvcNbr LIKE ' + QUOTENAME(@InvcNbr, '''')
		SELECT @wherestr = @wherestr + ' AND SOLine.InvtID LIKE ' + QUOTENAME(@InvtID, '''')
		SELECT @wherestr = @wherestr + ' AND SOLine.SiteID LIKE ' + QUOTENAME(@SiteID, '''')
		SELECT @sql = '
			SELECT SOHeader.* FROM SOHeader WITH (NOLOCK)
			  LEFT JOIN SOLine WITH (NOLOCK) ON SOLine.CpnyID = SOHeader.CpnyID AND SOLine.OrdNbr = SOHeader.OrdNbr
			  LEFT JOIN SOShipHeader WITH (NOLOCK) ON SOShipHeader.CpnyID = SOHeader.CpnyID AND SOShipHeader.OrdNbr = SOHeader.OrdNbr  '
			+ @wherestr + '  ORDER BY SOHeader.OrdNbr'
	END

	EXEC (@sql)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SO_Lookup_Summary] TO [MSDSL]
    AS [dbo];

