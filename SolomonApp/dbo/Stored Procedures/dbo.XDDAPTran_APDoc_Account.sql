
CREATE PROCEDURE XDDAPTran_APDoc_Account
   @RefNbr	varchar (10)

AS

   SELECT	T.Trandesc,
   		A.Descr,
		case when T.trantype = 'AD'
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
   FROM		APTran T (nolock) LEFT OUTER JOIN APDoc D (nolock)
		ON T.BatNbr = D.BatNbr and T.RefNbr = D.RefNbr
		LEFT OUTER JOIN Account A (nolock)
		ON T.Acct = A.Acct
   WHERE	((T.trantype IN ('VO', 'AC') and T.drcr = 'D') or
		(T.trantype = 'AD' and T.drcr = 'C'))
		and T.Refnbr = @RefNbr
   ORDER BY	T.LineNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDAPTran_APDoc_Account] TO [MSDSL]
    AS [dbo];

