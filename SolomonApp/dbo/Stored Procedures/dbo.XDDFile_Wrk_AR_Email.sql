
CREATE PROCEDURE XDDFile_Wrk_AR_Email
   @FileType		varchar(1),
   @EBFileNbr		varchar(6)

AS
   -- AR EFT - Order by Company Invoice Nbr - .ChkRefNbr
   -- VchRefNbr is the EFT Payment number
   SELECT	*
   FROM		XDDFile_Wrk
   WHERE	FileType = @FileType
		and EBFileNbr = @EBFileNbr
		ORDER BY ChkAcct, ChkSub, VendID, VendAcct, VchRefNbr, ChkRefNbr, RecordID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_AR_Email] TO [MSDSL]
    AS [dbo];

