
CREATE PROCEDURE XDDAPTran_S_RefNbr
   @RefNbr	varchar( 10 )

AS
	-- return 1, if unreleased MCB aptran for this voucher refnbr
	if Exists(Select * FROM APTran T (NoLock) LEFT OUTER JOIN APDoc C (nolock)
			ON T.BatNbr = C.BatNbr and T.RefNbr = C.RefNbr
   			WHERE	T.UnitDesc = @RefNbr
				and T.DrCr = 'S'
				and C.Rlsed = 0)
		Select convert(smallint, 1)
	else
		Select convert(smallint, 0)
	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDAPTran_S_RefNbr] TO [MSDSL]
    AS [dbo];

