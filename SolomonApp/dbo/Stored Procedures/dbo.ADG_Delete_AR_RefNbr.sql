 CREATE PROCEDURE ADG_Delete_AR_RefNbr
	@RefNbr		Varchar(10)
AS
	DELETE	RefNbr
	WHERE	RefNbr = @RefNbr


