CREATE PROCEDURE WS_Customer_DELETE
	@CustId char(15),
	@tstamp timestamp
	AS
	UPDATE [Customer] SET [CustId] = [CustId] WHERE [CustId] = @CustId AND [tstamp] = @tstamp
	 IF @@ROWCOUNT > 0 
	 BEGIN
	  DELETE FROM [CustContact]  
		WHERE [CustID] = @CustId;  
	  DELETE FROM [CustomerEDI]  
		WHERE [CustID] = @CustId;  
	  DELETE FROM [SOAddress]  
		WHERE [CustID] = @CustId;  
	  DELETE FROM [ARTran]   
		WHERE [CustID] = @CustId;  
	  DELETE FROM [ARAdjust]  
		WHERE [CustID] = @CustId; 
	  DELETE FROM [Customer]  
		WHERE [CustId] = @CustId
	 END  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_Customer_DELETE] TO [MSDSL]
    AS [dbo];

