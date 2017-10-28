CREATE PROCEDURE XDDTerms_ApplyTo
	@TermsID	varchar(2)
AS
-- Select termsid, descr From Terms, XDDSetup Where ApplyTo IN ('C','B') and TermsID LIKE rtrim(XDDSetup.ARTermsID) and TermsID LIKE @TermsID order by TermsID
Select Terms.* From Terms, XDDSetup Where ApplyTo IN ('C','B') and TermsID LIKE rtrim(XDDSetup.ARTermsID) and TermsID LIKE @TermsID order by TermsID
