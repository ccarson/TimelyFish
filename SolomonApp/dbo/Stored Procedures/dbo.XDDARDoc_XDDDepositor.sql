
CREATE PROCEDURE XDDARDoc_XDDDepositor
   @BatNbr	varchar(10)

AS

--   declare	@AcctAppOption	smallint
	
   -- Get Account Number Approval Option
-- SET		@AcctAppOption = 0
-- SELECT	@AcctAppOption = AcctApp
-- FROM		XDDSetupEX (nolock)

   SELECT       A.BankAcct, A.BankSub, F.FormatID
   FROM		ARDoc A (nolock) LEFT JOIN XDDDepositor D (nolock)
   		ON D.VendID = A.CustID and D.VendCust = 'C' LEFT JOIN XDDFileFormat F (nolock)
   		ON D.FormatID = F.FormatID
   WHERE	A.BatNbr = @BatNbr
   		and D.VendID <> ''
   		and ((F.PreNote = 1 and (D.PNStatus = 'A' or (D.PNStatus = 'P' and GetDate() >= D.PNDate)))
   		or (F.PreNote = 0))
   		and D.Status = 'Y'	-- Active
   		and ( (D.TermDate = Convert(SmallDateTime, '01/01/1900')) or 	-- Not terminated
   		      (D.TermDate <> Convert(SmallDateTime, '01/01/1900') and D.TermDate >= GetDate())
   		    )
--		and (@AcctAppOption = 0 or (@AcctAppOption <> 0 and D.AcctAppStatus = 'A'))	-- Account Approved     
