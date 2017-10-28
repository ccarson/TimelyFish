
CREATE PROCEDURE XDDPRDoc_Details_EBFileNbr
   @EBFileNbr		varchar( 6 ),
   @BatNbr		varchar( 10 ),	
   @Order		varchar( 1 )		-- "I"d, "N"ame

AS

   if @Order = 'I'
	   SELECT	P.*, E.*
	   FROM		XDDEBFile XF (nolock) LEFT OUTER JOIN XDDBatch XB (nolock)
			ON XF.EBFileNbr = XB.EBFileNbr and XF.FileType = XB.FileType LEFT OUTER JOIN PRDoc P (nolock)
			ON XB.BatNbr = P.BatNbr LEFT OUTER JOIN Employee E (nolock)
			ON P.EmpID = E.EmpID
	   WHERE	XF.EBFileNbr = @EBFileNbr
	   		and XB.Module = 'PR'
	   		and XF.FileType = 'P'
	   		and (	(P.Status <> 'V' and P.DocType <> 'VC') or	-- No voids in orig batch
	   			(P.Status = 'V' and P.DocType = 'VC') 		-- Only voids in void batch
	   		    )
	   		and P.DocType <> 'ZC'				-- No Zero Checks
	   		and P.DocType <> 'SC'				-- No Stub Checks
	   		and P.BatNbr LIKE @BatNbr
	   ORDER BY 	P.EmpID, P.ChkNbr

    else
	   SELECT	P.*, E.*
	   FROM		XDDEBFile XF (nolock) LEFT OUTER JOIN XDDBatch XB (nolock)
			ON XF.EBFileNbr = XB.EBFileNbr and XF.FileType = XB.FileType LEFT OUTER JOIN PRDoc P (nolock)
			ON XB.BatNbr = P.BatNbr LEFT OUTER JOIN Employee E (nolock)
			ON P.EmpID = E.EmpID
	   WHERE	XF.EBFileNbr = @EBFileNbr
	   		and XB.Module = 'PR'
	   		and XF.FileType = 'P'
	   		and (	(P.Status <> 'V' and P.DocType <> 'VC') or	-- No voids in orig batch
	   			(P.Status = 'V' and P.DocType = 'VC') 		-- Only voids in void batch
	   		    )
	   		and P.DocType <> 'ZC'				-- No Zero Checks
	   		and P.DocType <> 'SC'				-- No Stub Checks
	   		and P.BatNbr LIKE @BatNbr
	   ORDER BY 	E.Name, P.EmpID, P.ChkNbr
