
create procedure PMG_PJINVDET_Updt

   as

-- Note: We only want this update to be executed the first time PJINVDET
--       is converted. The test on the Adj_Amount field in the PMGOldPJInvdet
--       table does this.

Update pjinvdet
    Set adj_amount = -1 * amount,
        adj_units  = -1 * units

Update pjinvdet
	Set orig_amount = amount,
          orig_units  = units,
          adj_amount  = 0,
          adj_units   = 0
from pjinvdet, pjbill, pjrulip, account
WHERE
     	pjinvdet.project    = Pjbill.project
and   pjbill.bill_type_cd = Pjrulip.bill_type_cd
and   pjinvdet.acct       = Pjrulip.acct
and    (( pjrulip.gl_acct = account.acct
              and
             substring (account.accttype, 2, 1) = "A")
            OR
            ( pjrulip.credit_gl_acct = account.acct
              and
             substring (account.accttype, 2, 1) = "A")
            OR
            ( pjrulip.debit_gl_acct = account.acct
              and
             substring (account.accttype, 2, 1) = "A"))
-- End of proc

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PMG_PJINVDET_Updt] TO [MSDSL]
    AS [dbo];

