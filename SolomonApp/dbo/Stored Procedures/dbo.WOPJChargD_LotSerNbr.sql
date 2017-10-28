 CREATE PROCEDURE WOPJChargD_LotSerNbr
	@RecordID	varchar(25)

AS
	SELECT          *
	FROM            PJChargD
	WHERE           LotSerNbr = @RecordID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJChargD_LotSerNbr] TO [MSDSL]
    AS [dbo];

