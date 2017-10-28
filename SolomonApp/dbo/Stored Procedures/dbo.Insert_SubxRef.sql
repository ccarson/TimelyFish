 CREATE Procedure Insert_SubxRef
	@UserAddress 	varchar(21)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
/*****  Also we need to insert this subaccount in the system..subxref table throw the view*****/
INSERT vs_SubXRef (Active, CpnyID, Descr, Sub, User1, User2, User3, User4)
SELECT	1, c.CpnySub,'Sub Acct Added During Posting',g.sub,'','',0,0
FROM	GLTran g INNER JOIN vs_Company c ON g.CpnyID = c.CpnyID
	INNER JOIN WrkPost p ON p.Module=g.Module AND p.BatNbr=g.BatNbr INNER JOIN GLSetup s (NOLOCK) ON
	s.ValidateAcctSub=0 INNER JOIN FlexDef f ON f.FieldClassName='SUBACCOUNT' LEFT JOIN vs_SubXRef r ON
	r.CpnyID = c.CpnySub AND r.Sub=g.Sub
WHERE	p.UserAddress=@UserAddress AND s.SetupID='GL' AND f.ValidCombosRequired=0 AND r.Sub IS NULL
GROUP	BY c.CpnySub, g.Sub


