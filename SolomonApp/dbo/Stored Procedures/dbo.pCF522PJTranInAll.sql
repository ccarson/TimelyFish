



CREATE     PROCEDURE pCF522PJTranInAll
		  @parm1 varchar(10)

	AS
	Select * from pjtran 
	Where (acct='PIG TRANSFER IN' OR acct='PIG PURCHASE') 
	AND pjt_entity= @parm1 






GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF522PJTranInAll] TO [MSDSL]
    AS [dbo];

