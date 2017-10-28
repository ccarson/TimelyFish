 
CREATE VIEW VP_PurchOrd_TiedTo_SalesOrd AS 

SELECT DISTINCT p.SOOrdNbr, p.SOLineRef, p.SOSchedRef, p.CpnyID, p.PONbr, p2.PurchaseType, l.InvtID, l.SiteID, l.WhseLoc, l.LotSerNbr, POExistOrder = 1    
  FROM POAlloc p JOIN SOSched s
                   ON p.SOOrdNbr = s.OrdNbr
                  AND p.SOLineRef = s.LineRef
                  AND p.SOSchedRef = s.SchedRef
                  AND p.CpnyID = s.CpnyID
                 JOIN POTran p2 ON p.PONbr = p2.PONbr
                               AND p.POLineRef = p2.LineRef
                 JOIN INTran i
                  ON i.RefNbr = p2.RcptNbr
                 AND i.LineRef = p2.LineRef
                 AND i.InvtID = p2.InvtID 
                JOIN LotSerT l
                  ON i.Batnbr = l.Batnbr
                         AND i.RefNbr = l.RefNbr
                         AND i.LineRef = l.INTranLineRef
                         AND i.TranType = l.TranType
                         AND i.InvtID = l.InvtID
                         AND i.SiteID = l.SiteID
                         AND i.TranType IN ('RC','II', 'RP')


