---------------------------------FINISH STORED PROC pp_03400-------------------------------------------------------------------

-- Changes for bug 31889
---------------------------------BEGIN STORED PROC APPO_PurOrdDet_PONbr_NotVouched2-------------------------------------------------------------------
CREATE PROC APPO_PurOrdDet_PONbr_NotVouched2 @parm1 VARCHAR(10) AS
SELECT *
 FROM PurOrdDet
 WHERE PONbr = @parm1
   AND VouchStage <> 'F' -- Not fully Vouchered
   AND ((PurchaseType IN ('GD','SE','SP','SW') -- Any items that must be vouchered direct from the PO and are not an unreleased voucher
         AND NOT EXISTS(SELECT *
                         FROM APTran
                         WHERE APTran.PONbr = @parm1
                          AND APTran.POLineRef = PurOrdDet.LineRef
                          AND APTran.Rlsed = 0))
        OR (PurchaseType IN ('GI','GP','GS','GN','PS','PI','MI','FR') -- Any items that must be on a receipt to be vouchered, but aren't
		    AND RcptStage <> 'F'))
 ORDER BY PONbr, LineNbr

