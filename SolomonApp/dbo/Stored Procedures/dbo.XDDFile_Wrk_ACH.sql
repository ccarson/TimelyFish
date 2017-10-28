
CREATE PROCEDURE XDDFile_Wrk_ACH
   @FileType		varchar(1),
   @ComputerName	varchar(21)

AS
   SELECT	*
   FROM		XDDFile_Wrk
   WHERE	FileType = @FileType
   		and ComputerName = @ComputerName
   ORDER BY	RecSection, DepEntryClass, RecType,
   		ChkAcct, ChkSub, VendID, ChkBatNbr, ChkRefNbr, VchDocType DESC, RecordID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_ACH] TO [MSDSL]
    AS [dbo];

