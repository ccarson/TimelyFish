
 CREATE PROCEDURE POTran_PONbr_Rcpted
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM POTran
	WHERE PONbr LIKE @parm1
		AND POTran.trantype <> 'X'
		AND PurchaseType in ('GI','GP','GS','GN','PS','PI','MI','FR')

GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTran_PONbr_Rcpted] TO [MSDSL]
    AS [dbo];

