
CREATE PROCEDURE XDDFile_Wrk_ACH_Pmt_Applic
   @FileType		varchar(1),
   @EBFileNbr		varchar(6)

AS
   SELECT	*
   FROM		XDDFile_Wrk
   WHERE	FileType = @FileType
   		and EBFileNbr = @EBFileNbr
                and RecSection = '20P'
		and RecType = '10V'
   ORDER BY	RecSection, DepEntryClass, RecType,
   		VchCpnyID, VchCuryID, VendID, ChkAcct, ChkSub, ChkBatNbr, ChkRefNbr, VchDocType DESC, RecordID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_ACH_Pmt_Applic] TO [MSDSL]
    AS [dbo];

