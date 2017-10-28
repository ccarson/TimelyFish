CREATE PROCEDURE WS_CustContact_DELETE
	@ContactID char(10),
	@CustID char(15),
	@tstamp timestamp
	AS
	BEGIN
	DELETE FROM [CustContact]
	WHERE [ContactID] = @ContactID AND 
	[CustID] = @CustID AND 
	[tstamp] = @tstamp;
	END                

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_CustContact_DELETE] TO [MSDSL]
    AS [dbo];

