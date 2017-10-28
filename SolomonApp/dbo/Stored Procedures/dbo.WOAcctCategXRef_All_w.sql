
CREATE PROCEDURE WOAcctCategXRef_All_w
   @Acct       varchar( 16 )
AS
   SELECT      WIPAcct_NonMfg, WIPAcct_Mfg
   FROM        WOAcctCategXRef
   WHERE       Acct LIKE @Acct

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOAcctCategXRef_All_w] TO [MSDSL]
    AS [dbo];

