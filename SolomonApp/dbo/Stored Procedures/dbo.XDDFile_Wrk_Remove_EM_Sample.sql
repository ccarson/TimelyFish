
CREATE PROCEDURE XDDFile_Wrk_Remove_EM_Sample
  	@EBFileNbr	varchar( 6 )
AS

	DELETE	FROM    XDDFile_Wrk
	WHERE		EBFileNbr = @EBFileNbr

