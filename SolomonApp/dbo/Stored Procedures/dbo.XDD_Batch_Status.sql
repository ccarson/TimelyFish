CREATE PROCEDURE XDD_Batch_Status
	@Module		varchar(2),
	@BatNbr		varchar(10)
AS
  	Select 		Status
  	FROM 		Batch (nolock)
  	WHERE 		Module = @Module
  			and BatNbr LIKE @BatNbr
