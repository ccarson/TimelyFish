
CREATE PROCEDURE XDDFile_Wrk_KeepDelete_Email
   @FileType		varchar (1),
   @EBFileNbr		varchar (6),
   @Acct		varchar (10),
   @SubAcct		varchar (24),
   @VendID		varchar (15),
   @VendAcct		varchar (10),
   @KeepDelete		varchar (1)
AS
   UPDATE		XDDFile_Wrk
   SET			KeepDelete = @KeepDelete
   WHERE		FileType = @FileType
   			and EBFileNbr = @EBFileNbr
   			and ChkAcct = @Acct
   			and ChkSub = @SubAcct
   			and VendID = @VendID
			and VendAcct = @VendAcct

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_KeepDelete_Email] TO [MSDSL]
    AS [dbo];

