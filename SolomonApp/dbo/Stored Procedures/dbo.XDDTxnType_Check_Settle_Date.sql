
CREATE PROCEDURE XDDTxnType_Check_Settle_Date
AS

	SELECT	T.*
	FROM	XDDTxnType T (nolock) LEFT OUTER JOIN XDDFileFormat F (nolock)
		ON T.FormatID = F.FormatID
	WHERE	F.Selected = 'Y'
		and T.Selected = 'Y'
		and T.ChkWF = 'M'
		and T.ChkWF_CreateMCB = 'S'	-- Settlement Date batches
