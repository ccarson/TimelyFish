
CREATE PROCEDURE XDDARTran_ARDoc_Account
   @RefNbr	varchar (10)

AS

   SELECT	T.Trandesc,
   		A.Descr,
		case when T.trantype = 'CM'
			then -T.curytranamt
			else T.curytranamt
			end,
		T.User1,
		T.User2,	
		T.User3,	
		T.User4,	
		T.User5,	
		T.User6,	
		T.User7,	
		T.User8	
   FROM		ARTran T (nolock) LEFT OUTER JOIN ARDoc D (nolock)
		ON T.BatNbr = D.BatNbr and T.RefNbr = D.RefNbr
		LEFT OUTER JOIN Account A (nolock)
		ON T.Acct = A.Acct
   WHERE	((T.trantype IN ('IN', 'DM') and T.drcr = 'C') or
		(T.trantype = 'CM' and T.drcr = 'D'))
		and T.Refnbr = @RefNbr
		and T.CuryTranAmt > 0
   ORDER BY	T.LineNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDARTran_ARDoc_Account] TO [MSDSL]
    AS [dbo];

