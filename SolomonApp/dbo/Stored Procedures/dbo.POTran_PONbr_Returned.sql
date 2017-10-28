
 CREATE PROCEDURE POTran_PONbr_Returned
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM POTran
	WHERE PONbr LIKE @parm1
		AND POTran.trantype = 'X'
		AND PurchaseType in ('GI','GP','GS','GN','PS','PI','FR','MI')

GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTran_PONbr_Returned] TO [MSDSL]
    AS [dbo];

