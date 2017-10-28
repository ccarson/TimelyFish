
Create Procedure Insert_ProjAlloc_Receipt 
       @SolUser VarChar(47), 
       @RcptNbr VarChar(15), 
       @LineRef VarChar(5),
       @QtyPrec	Int, 
       @CostPrec Int,
       @Batnbr VarChar(10),
       @RecordID Integer
AS

--Insert the Project Allocated Inventory for Receipts
INSERT INVProjAlloc(CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, InvtID, 
       LUpd_DateTime, LUpd_Prog, LUpd_User, OrdNbr, PerNbr,  
       PO_QtyOrd, PO_UnitCost, PO_UOM, POLineRef, PONbr,  
       ProjectID, QtyAllocated, QtyRemainToIssue, S4Future01, S4Future02,  
       S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, 
       S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,  
       SiteID, SrcDate, SrcLineRef, SrcNbr, SrcType,  
       TaskID, UnitCost, UnitDesc, User1, User2, 
       User3, User4, User5, User6, User7,  
       User8, WhseLoc,WIP_COGS_Acct, WIP_COGS_Sub)
SELECT p.CpnyID, GetDate(), '10400', @SolUser, p.InvtID, 
       GetDate(), '10400', @SolUser, p.SOOrdNbr, p.PerPost, 
       CASE WHEN d.PONbr IS NULL THEN 0 ELSE d.QtyOrd END, 
       CASE WHEN d.PONbr IS NULL THEN 0 ELSE d.UnitCost END, 
       CASE WHEN d.PONbr IS NULL THEN ' ' ELSE d.PurchUnit END, p.POLineRef, p.PONbr,  
       p.ProjectID, CASE p.RcptMultDiv 
                      WHEN 'M' 
                        THEN round(p.Rcptqty * p.RcptConvFact, @QtyPrec) --INSetup.DecPlQty)
                      WHEN 'D'
                        THEN round(p.Rcptqty / p.RcptConvFact, @QtyPrec) --INSetup.DecPlQty)
                      ELSE p.RcptQty END, 
       CASE p.RcptMultDiv 
         WHEN 'M' 
           THEN round(p.Rcptqty * p.RcptConvFact, @QtyPrec) --INSetup.DecPlQty)
         WHEN 'D'
           THEN round(p.Rcptqty / p.RcptConvFact, @QtyPrec) --INSetup.DecPlQty)
         ELSE p.RcptQty END, ' ', ' ',  
       0,0,0,0,'',
       ' ',0,0,' ',' ',
       p.SiteID, p.RcptDate, p.LineRef, p.RcptNbr, 
       CASE WHEN p.PurchaseType = 'PS' 
              THEN 'GSO'
            ELSE
              CASE WHEN d.PONbr IS NULL 
                     THEN 'PRR' 
                   ELSE 'POR' 
              END
       END,  
       p.TaskID, CASE WHEN d.PONbr IS NULL 
                      THEN CASE WHEN p.RcptUnitDescr = v.stkunit 
                                THEN p.UnitCost
                                ELSE p.ExtCost/(CASE p.RcptMultDiv 
                                                         WHEN 'M' 
                                                           THEN round(p.Rcptqty * p.RcptConvFact, @QtyPrec) --INSetup.DecPlQty)
                                                         WHEN 'D'
                                                           THEN round(p.Rcptqty / p.RcptConvFact, @QtyPrec) --INSetup.DecPlQty)
                                                        ELSE p.RcptQty END)  --INSetup.DecPlPrcCst
                            END
                      ELSE CASE WHEN d.PurchUnit = v.stkunit
                                 THEN d.UnitCost
                                ELSE d.ExtCost/(CASE d.UnitMultDiv 
                                                         WHEN 'M' 
                                                           THEN round(d.QtyOrd * d.CNVFact, @QtyPrec) --INSetup.DecPlQty)
                                                         WHEN 'D'
                                                           THEN round(d.QtyOrd / d.CNVFact, @QtyPrec) --INSetup.DecPlQty)
                                                        ELSE p.RcptQty END)  --INSetup.DecPlPrcCst
                           END
                  END, v.stkunit, ' ',' ',  
       0, 0,' ',' ',' ', 
       ' ' , p.WhseLoc, p.WIP_COGS_Acct, p.WIP_COGS_Sub
  FROM PORECEIPT r JOIN POTran p
                     ON p.RcptNbr = r.RcptNbr
                   LEFT OUTER JOIN PurOrdDet d
                     ON p.PONbr = d.PONbr
                    AND p.POLineRef = d.LineRef
				   JOIN Inventory v
                     ON p.InvtID = v.InvtID
 WHERE p.RcptNbr = @RcptNbr
   AND p.LineRef = @LineRef
   AND r.Status = 'C' 
   AND p.PurchaseType IN ('PI','PS')
   AND p.ProjectID <> ' '
   
-- Insert the Project Allocated Lot/Serial Numbers for Receipts
INSERT InvProjAllocLot (AllocationLineID, AllocationLineRef, AllocationQty, CpnyID, Crtd_DateTime, 
       Crtd_Prog, Crtd_User, InvtID, LotSerNbr, LotSerRef, 
       LUpd_DateTime, LUpd_Prog, LUpd_User, MfgrLotSerNbr, ProjectID, 
       QtyRemainToIssue, S4Future01, S4Future02, S4Future03, S4Future04, 
       S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, 
       S4Future10, S4Future11, S4Future12, SiteID, SpecificCostID, 
       SrcDate, SrcLineRef, SrcNbr, SrcType, TaskID, 
       UnitDesc, User1, User2, User3, User4, 
       User5, User6, User7, User8, WhseLoc)
SELECT p.LineID, p.LineRef, l.qty, l.CpnyID, GetDate(), 
       (10400), @SolUser, l.InvtID, l.LotSerNbr, l.LotSerRef, 
       GetDate(), '10400', @SolUser, l.MfgrLotSerNbr, p.ProjectID, 
       l.Qty, ' ', ' ', 0, 0, 
       0, 0,' ', ' ',0, 
       0,' ',' ', l.SiteID, ' ', 
       p.RcptDate, p.LineRef, p.RcptNbr, 
       CASE WHEN p.PurchaseType = 'PS' 
              THEN 'GSO'
            ELSE
              CASE WHEN d.PONbr IS NULL 
                     THEN 'PRR' 
                   ELSE 'POR' 
              END
       END, p.TaskID, 
       v.stkunit, ' ',' ', 0, 0, 
       ' ',' ',' ', ' ', l.WhseLoc
  FROM INTran i JOIN LotSerT l
                  ON i.Batnbr = l.BatNbr
                 AND i.CpnyID = l.CpnyID
                 AND i.SiteID = l.SiteID
                 AND i.LineRef = l.INTranLineRef
                JOIN POTran p
                  ON p.RcptNbr = i.RcptNbr 
                LEFT OUTER JOIN PurOrdDet d
                  ON p.PONbr = d.PONbr
                 AND p.POLineRef = d.LineRef
				JOIN Inventory v
                  ON p.InvtID = v.InvtID
 WHERE i.Batnbr = @BatNbr
   AND i.RecordID = @RecordID
   AND i.TranType = 'RC'
   AND l.Rlsed = 1
   AND p.RcptNbr = @RcptNbr
   AND p.LineRef = @LineRef
   AND p.PurchaseType IN ('PI','PS')
   AND p.ProjectID <> ' '
