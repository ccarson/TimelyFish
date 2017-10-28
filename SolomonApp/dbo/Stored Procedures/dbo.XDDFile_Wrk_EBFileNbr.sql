
CREATE PROCEDURE XDDFile_Wrk_EBFileNbr
   @FileType		varchar(1),
   @EBFileNbr		varchar(6)

AS
   SELECT	*
   FROM		XDDFile_Wrk
   WHERE	FileType = @FileType
   		and EBFileNbr = @EBFileNbr
   ORDER BY	RecSection, DepEntryClass, DepISOCntry, RecType,
   		ChkAcct, ChkSub, VendID, VendAcct, ChkBatNbr, ChkRefNbr, VchDocType DESC, RecordID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_EBFileNbr] TO [MSDSL]
    AS [dbo];

