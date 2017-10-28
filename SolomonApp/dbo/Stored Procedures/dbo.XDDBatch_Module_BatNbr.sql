CREATE PROCEDURE XDDBatch_Module_BatNbr
	@Module		varchar(2),
	@BatNbr		varchar(10)
AS
  	Select 		*
  	FROM 		XDDBatch
  	WHERE 		Module = @Module
  			and BatNbr LIKE @BatNbr
