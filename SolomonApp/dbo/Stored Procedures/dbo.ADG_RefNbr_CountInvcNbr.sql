 CREATE PROCEDURE ADG_RefNbr_CountInvcNbr
	@RefNbr		Varchar(10)
AS
	SELECT	Count(*)
	FROM	RefNbr
	WHERE	RefNbr = @RefNbr


