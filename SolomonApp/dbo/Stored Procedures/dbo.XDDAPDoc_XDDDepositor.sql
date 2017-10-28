
CREATE PROCEDURE XDDAPDoc_XDDDepositor
   @BatNbr	varchar(10)

AS

   declare	@AcctAppOption	smallint

   -- is eBanking Security being used, if so, is it setup for Acct Number Approval?
   SET		@AcctAppOption = 0
   SELECT	@AcctAppOption = ModeBankSecurity
   FROM		XDDSetup (nolock)

   if @AcctAppOption = 1   	
      	SELECT	@AcctAppOption = AcctApp
      	FROM	XDDSetupEX (nolock)

   -- Format ID was coming from XDDDepositors in the batch
   -- Changed now to come from the related paying account
   SELECT       C.Acct, C.Sub, 
     		case when T.TxnNACHA = 1 	-- in case the VBE has non-USACH Format
   			then 'US-ACH'
   			else F.FormatID
   			end
   FROM		APDoc C (nolock) right outer join APAdjust A (nolock)
		ON C.Acct = A.AdjgAcct and C.Sub = A.AdjgSub and C.DocType = A.AdjgDoctype 
			and C.RefNbr = A.AdjgRefNbr and A.AdjgDocType <> 'ZC' LEFT OUTER JOIN APDoc V (nolock)
		ON A.VendID = V.VendID and A.AdjdDoctype = V.DocType and A.AdjdRefNbr = V.RefNbr LEFT JOIN XDDDepositor D (nolock)
   		ON D.VendID = C.Vendid and D.VendCust = 'V'and D.VendAcct = V.eConfirm LEFT OUTER JOIN XDDBank B (nolock)
   		ON C.CpnyID = B.CpnyID and C.Acct = B.Acct and C.Sub = B.sub LEFT OUTER JOIN XDDFileFormat F (nolock) 
   		ON D.FormatID = F.FormatID LEFT OUTER JOIN XDDTxnType T (nolock)   
     		ON V.EStatus = T.EStatus and D.FormatID = T.FormatID
   WHERE	C.BatNbr = @BatNbr
   		and D.VendID <> ''
   		and ((F.PreNote = 1 and (D.PNStatus = 'A' or (D.PNStatus = 'P' and GetDate() >= D.PNDate)))
   		or (F.PreNote = 0))
   		and D.Status = 'Y'	-- Active
   		and ( (D.TermDate = Convert(SmallDateTime, '01/01/1900')) or 	-- Not terminated
   		      (D.TermDate <> Convert(SmallDateTime, '01/01/1900') and D.TermDate >= GetDate())
   		    )
		and (@AcctAppOption = 0 or (@AcctAppOption <> 0 and D.AcctAppStatus = 'A'))	-- Account Approved     
   		and V.eStatus <> ''

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDAPDoc_XDDDepositor] TO [MSDSL]
    AS [dbo];

