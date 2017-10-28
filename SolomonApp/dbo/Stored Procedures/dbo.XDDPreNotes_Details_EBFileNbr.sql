
CREATE PROCEDURE XDDPreNotes_Details_EBFileNbr
   @FileType		varchar( 1 ),
   @EBFileNbr		varchar( 6 ),
   @Order		varchar( 1 )		-- "I"d, "N"ame

AS

   if @Order = "I"
	   SELECT	D.*
	   FROM		XDDFile_Wrk W (nolock) LEFT OUTER JOIN XDDDepositor D (nolock) 
	   		ON W.VendID = D.VendID and W.VendCust = D.VendCust and W.VendAcct = D.VendAcct
	   WHERE	W.EBFileNbr = @EBFileNbr
	   		and W.FileType = @FileType
	   		and W.RecType = '20P'
			and W.VendID <> ''
	   ORDER BY 	W.VendID
    else
	   SELECT	D.*
	   FROM		XDDFile_Wrk W (nolock) LEFT OUTER JOIN XDDDepositor D (nolock) 
	   		ON W.VendID = D.VendID and W.VendCust = D.VendCust and W.VendAcct = D.VendAcct
	   WHERE	W.EBFileNbr = @EBFileNbr
	   		and W.FileType = @FileType
	   		and W.RecType = '20P'
			and W.VendID <> ''
	   ORDER BY 	W.VendName, W.VendID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDPreNotes_Details_EBFileNbr] TO [MSDSL]
    AS [dbo];

