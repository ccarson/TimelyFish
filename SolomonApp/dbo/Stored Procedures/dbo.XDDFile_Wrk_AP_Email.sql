

CREATE PROCEDURE XDDFile_Wrk_AP_Email
   @FileType		varchar(1),
   @EBFileNbr		varchar(6)

AS
   -- AP EFT - Order by Vendor Invoice Nbr - .VchInvcNbr (may be blank)
   SELECT	*
   FROM		XDDFile_Wrk
   WHERE	FileType = @FileType
   		and EBFileNbr = @EBFileNbr
   ORDER BY	ChkAcct, ChkSub, VendID, VendAcct, ChkRefNbr, VchInvcNbr, VchRefNbr, RecordID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_AP_Email] TO [MSDSL]
    AS [dbo];

