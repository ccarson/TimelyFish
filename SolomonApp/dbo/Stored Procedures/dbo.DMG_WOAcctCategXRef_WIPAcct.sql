 create proc DMG_WOAcctCategXRef_WIPAcct
	@GLAcct	varchar(10)
AS
	select		X.WIPAcct_Mfg, X.WIPAcct_NonMfg
	from		Account GLA LEFT OUTER JOIN PJ_Account PA
				ON PA.gl_acct = GLA.Acct
				LEFT OUTER JOIN WOAcctCategXRef X
				ON X.Acct = PA.Acct
	Where		GLA.Active = 1 and
				GLA.Acct LIKE @GLAcct and
				(X.WIPAcct_Mfg <> '' or X.WIPAcct_NonMfg <> '')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_WOAcctCategXRef_WIPAcct] TO [MSDSL]
    AS [dbo];

