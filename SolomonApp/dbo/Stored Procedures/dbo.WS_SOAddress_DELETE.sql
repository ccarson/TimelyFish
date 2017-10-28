CREATE PROCEDURE WS_SOAddress_DELETE
	@CustId char(15),
	@ShipToId char(10),
	@tstamp timestamp
	AS
	BEGIN
	DELETE FROM [SOAddress]
	WHERE [CustId] = @CustId AND 
	[ShipToId] = @ShipToId AND 
	[tstamp] = @tstamp;
	END	
