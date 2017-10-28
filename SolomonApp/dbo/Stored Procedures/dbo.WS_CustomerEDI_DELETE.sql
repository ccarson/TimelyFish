CREATE PROCEDURE WS_CustomerEDI_DELETE
	@CustID char(15),
	@tstamp timestamp
	AS
	BEGIN
	DELETE FROM [CustomerEDI]
	WHERE [CustID] = @CustID AND 
	[tstamp] = @tstamp;
	END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_CustomerEDI_DELETE] TO [MSDSL]
    AS [dbo];

