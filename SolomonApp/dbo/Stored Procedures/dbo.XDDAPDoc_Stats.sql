
CREATE PROCEDURE XDDAPDoc_Stats
   @VendID		varchar( 15 ),
   @VendCust		varchar( 1 )		-- 'V'endor, 'C'ustomer

AS

   Declare @OpenDoc		smallint
   Declare @Selected		smallint
   Declare @KeptNotTransmitted	smallint

   SET	   @OpenDoc = 0
   SET	   @Selected = 0
   SET	   @KeptNotTransmitted = 0
	   
   if @VendCust = 'V'
   BEGIN
	   -- OpenDocs but not Selected
	   SELECT  	@OpenDoc = count(*) 
	   FROM		APDoc (nolock)
	   WHERE	VendID LIKE @VendID
			And OpenDoc = 1
			and CuryDocBal > 0
			and Selected = 0
			and Rlsed = 1
			and DocType IN ('VO', 'AD', 'AC')

	   -- Selected
	   SELECT  	@Selected = count(*) 
	   FROM		APDoc (nolock)
	   WHERE	VendID LIKE @VendID
			And OpenDoc = 1
			and CuryDocBal > 0
			and Selected = 1
			and Rlsed = 1
			and DocType IN ('VO', 'AD', 'AC')

	   -- Printed Checks, but not yet sent via eBanking
	   SELECT  	@KeptNotTransmitted = count(*) 
	   FROM		APDoc D (nolock) LEFT OUTER JOIN XDDBatch B (nolock)
	   		ON D.BatNbr = B.BatNbr and B.Module = 'AP'
	   WHERE	D.VendID LIKE @VendID
			and D.Selected = 0
			and D.Rlsed = 1
			and D.DocType IN ('CK')
			and (B.BatNbr Is Null or (B.BatNbr Is Not Null and B.DepDate = 0))

   END

   else
   
   BEGIN

	   -- Open Invoices
	   SELECT  	@OpenDoc = count(*) 
	   FROM		ARDoc (nolock)
	   WHERE	CustID LIKE @VendID
			And OpenDoc = 1
			and CuryDocBal > 0
			and Rlsed = 1
			and DocType IN ('IN', 'CM', 'DM')

	   -- Coded Invoices, but not yet sent via eBanking
	   SELECT  	@KeptNotTransmitted = count(*) 
	   FROM		ARDoc A LEFT OUTER JOIN XDDBatchAREFT B
			ON A.BatNbr = B.BatNbr and A.RefNbr = B.RefNbr LEFT OUTER JOIN XDDBatch X (nolock)
	   		ON A.BatNbr = X.BatNbr and X.Module = 'AR'
	   WHERE	A.CustID LIKE @VendID
			and A.Rlsed = 1
			and A.DocType IN ('IN', 'DM')
			and (X.BatNbr Is Not Null and X.DepDate = 0)

   END

   SELECT	@OpenDoc, @Selected, @KeptNotTransmitted
   
--   SELECT	Convert(smallint, @OpenDoc), convert(smallint, @Selected), convert(smallint, @KeptNotTransmitted)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDAPDoc_Stats] TO [MSDSL]
    AS [dbo];

