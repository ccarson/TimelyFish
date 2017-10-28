
CREATE PROCEDURE XDDFile_Wrk_Get_MCB_Release
   @FileType		varchar( 1 ),
   @EBFileNbr		varchar( 6 )
   
AS


   declare @UpdateMCB    	varchar( 2 )

   -- First check if we have any Review Rates - (RA) - this will trump any other options
   SET @UpdateMCB = ''

   -- By using B.FormatID we'll get the original format (in case this is a US-ACH format, spawned from a Wire format)
   -- If so, we'll now get the ChkWF_UpdateMCB setting from the original wire format txn type.
   SELECT TOP 1	@UpdateMCB = T.ChkWF_UpdateMCB
   FROM	XDDFile_Wrk W (nolock) LEFT OUTER JOIN XDDBank B (nolock)
   		ON W.ChkCpnyID = B.CpnyID and W.ChkAcct = B.Acct and W.ChkSub = B.Sub LEFT OUTER JOIN XDDTxnType T (nolock)
   		ON B.FormatID = T.FormatID and W.DepEntryClass = T.EntryClass
   WHERE	W.FileType = @FileType
   		and W.EBFileNbr = @EBFileNbr
   		and W.ChkDocType IN ('HC', 'EP')
   		and T.ChkWF = 'M'
   		and W.RecType = '10V'
   		and T.ChkWF_UpdateMCB = 'RA'
   
   -- By using B.FormatID we'll get the original format (in case this is a US-ACH format, spawned from a Wire format)
   -- If so, we'll now get the ChkWF_UpdateMCB setting from the original wire format txn type.
   -- Didn't find a RA type, then get any other...
   if @UpdateMCB = ''		             
        SELECT TOP 1	@UpdateMCB = T.ChkWF_UpdateMCB
        FROM	XDDFile_Wrk W (nolock) LEFT OUTER JOIN XDDBank B (nolock)
   		ON W.ChkCpnyID = B.CpnyID and W.ChkAcct = B.Acct and W.ChkSub = B.Sub LEFT OUTER JOIN XDDTxnType T (nolock)
   		ON B.FormatID = T.FormatID and W.DepEntryClass = T.EntryClass
        WHERE	W.FileType = @FileType
   		and W.EBFileNbr = @EBFileNbr
   		and W.ChkDocType IN ('HC', 'EP')
   		and T.ChkWF = 'M'
   		and W.RecType = '10V'
   		            
   -- Return the value 		            
   SELECT @UpdateMCB		            

