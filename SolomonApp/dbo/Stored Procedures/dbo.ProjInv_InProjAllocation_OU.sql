
Create Proc ProjInv_InProjAllocation_OU        
       @RcptNbr VarChar(15), 
       @LineRef VarChar(5)
AS
 
SELECT a.SOOrdNbr, a.SOLineRef, a.CpnyID, QtyAlloc = (SUM(a.QtyRcvd) - SUM(a.QtyShip))
  FROM POAlloc a JOIN (SELECT DISTINCT p.PONbr, p.POLineRef, p.SOOrdNbr, p.SOLineRef, p.CpnyID 
                         FROM POAlloc p JOIN POTran t
                                        ON p.PONbr = t.PONbr
                                       AND p.POLineRef = t.POLineRef
                                       AND p.CpnyID = t.CpnyID
                        WHERE t.RcptNbr = @RcptNbr
                          AND t.LineRef = @LineRef
                          AND t.PurchaseType = 'PS' ) d
                   ON d.SOOrdNbr = a.SOOrdNbr
                  AND d.SOLineRef = a.SOLineRef
                  AND d.CpnyID = a.CpnyID   
 GROUP BY a.SOOrdNbr, a.SOLineREf, a.CpnyID  


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_InProjAllocation_OU] TO [MSDSL]
    AS [dbo];

