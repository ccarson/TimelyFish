
CREATE PROCEDURE XDDFile_Wrk_Acct_Sub_CpnyID
   @FileType		varchar(1),
   @EBFileNbr		varchar(6)

AS
   SELECT TOP 1	ChkAcct, ChkSub, ChkCpnyID
   FROM		XDDFile_Wrk
   WHERE	FileType = @FileType
   		and EBFileNbr = @EBFileNbr
   		and RecSection = '20P'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_Acct_Sub_CpnyID] TO [MSDSL]
    AS [dbo];

