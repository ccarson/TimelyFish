---------------------------------End STORED PROC APPO_PurOrdDet_PONbr_NotVouched2 -----------------------------------------

---------------------------------BEGIN STORED PROC PurOrdDet_NonRcpted ---------------------------------------
CREATE PROCEDURE PurOrdDet_NonRcpted @parm1 VARCHAR(10), @parm2 VARCHAR(5) AS
SELECT *
 FROM PurOrdDet
 WHERE PONbr LIKE @parm1
   AND LineRef LIKE @parm2
   AND (PurchaseType IN('GD','SE','SP','SW')
        OR (PurchaseType in ('GI','GP','GS','GN','PS','PI','MI','FR') -- Any items the must be on a receipt to be vouchered, but aren't
		    AND RcptStage <> 'F'))
 ORDER BY PONbr, LineRef


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_NonRcpted] TO [MSDSL]
    AS [dbo];

