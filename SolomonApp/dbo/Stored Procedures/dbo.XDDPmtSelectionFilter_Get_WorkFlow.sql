
CREATE PROCEDURE XDDPmtSelectionFilter_Get_WorkFlow
   @AccessNbr	smallint,
   @EBGroup	varchar( 2 )

AS
  
   SELECT	T.ChkWF,
   		T.ChkWF_CreateMCB
   FROM		XDDWrkCheckSel W (nolock) LEFT OUTER JOIN XDDTxnType T (nolock)
		ON W.EBFormatID = T.FormatID and W.EBEStatus = T.EStatus
   WHERE	W.AccessNbr = @AccessNbr
   		and W.EBGroup = @EBGroup

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDPmtSelectionFilter_Get_WorkFlow] TO [MSDSL]
    AS [dbo];

