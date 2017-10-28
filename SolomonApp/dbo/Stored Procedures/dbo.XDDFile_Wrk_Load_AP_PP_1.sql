
CREATE PROCEDURE XDDFile_Wrk_Load_AP_PP_1
   @BatNbr	varchar(10)

AS
   SELECT	APAdjust.*, C.*, APDoc.RefNbr, APDoc.DocType
   FROM		APAdjust (NoLock),
   		APDoc (NoLock),				-- Voucher
   		APDoc C (NoLock)			-- Check
   WHERE	APAdjust.AdjdRefNbr = APDoc.RefNbr
   		and APAdjust.AdjdDocType = APDoc.DocType
   		and APAdjust.AdjgAcct = C.Acct
   		and APAdjust.AdjgSub = C.Sub
   		and APAdjust.AdjgDocType = C.DocType
   		and APAdjust.AdjgRefNbr = C.RefNbr
   		and (	(C.Status <> 'V' and C.DocType <> 'VC') or	-- No voids in orig batch
   			(C.Status = 'V' and C.DocType = 'VC') 		-- Only voids in void batch
   		    )
--   		and APAdjust.AdjgDocType <> 'ZC'			-- No Zero Checks
   		and APAdjust.AdjgDocType <> 'SC'			-- No Stub Checks
   		and APAdjust.AdjBatnbr = @BatNbr

UNION

-- Voids created in AP Check Update - not in Void Entry (no APAdjust record)
   SELECT	APAdjust.*, C.*, APDoc.RefNbr, APDoc.DocType
   FROM		APAdjust (NoLock) RIGHT OUTER JOIN APDoc (nolock)
		ON APAdjust.AdjdRefNbr = APDoc.RefNbr and APAdjust.AdjdDocType = APDoc.DocType RIGHT OUTER JOIN APDoc C (nolock)
   		ON APAdjust.AdjgAcct = C.Acct and APAdjust.AdjgSub = C.Sub and APAdjust.AdjgDocType = C.DocType	and APAdjust.AdjgRefNbr = C.RefNbr
   WHERE	(C.Status = 'V' and C.DocType = 'VC') 		
		and APAdjust.AdjBatNbr Is Null
   		and C.Batnbr = @BatNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_Load_AP_PP_1] TO [MSDSL]
    AS [dbo];

