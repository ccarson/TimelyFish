

CREATE Procedure Insert_ProjAlloc_RetProj
       @SolUser VarChar(47), 
       @RcptNbr VarChar(15), 
       @LineRef VarChar(5),
       @QtyPrec	Int, 
       @CostPrec Int,
       @Batnbr VarChar(10),
       @RecordID Integer,
       @IssueAcct VarChar(10),
       @IssueSub VarChar(24)
AS

--Insert the Project Allocated Inventory for Return To Project
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
SELECT i.CpnyID, GetDate(), '10400', @SolUser, i.InvtID, 
       GetDate(), '10400', @SolUser, '', i.PerPost, 
       '', '', '', '', '', i.ProjectID, 
 	  CASE WHEN i.UnitDesc = v.StkUnit Then i.Qty
		   ELSE CASE i.UnitMultDiv 
                      WHEN 'M' 
                        THEN round(i.Qty * i.CnvFact, @QtyPrec) --INSetup.DecPlQty)
                     WHEN 'D'
                        THEN round(i.Qty / i.CnvFact, @QtyPrec) --INSetup.DecPlQty)
                      ELSE i.Qty END
	   END, 
       CASE WHEN i.UnitDesc = v.StkUnit Then i.Qty
			ELSE CASE i.UnitMultDiv 
				WHEN 'M' 
				  THEN round(i.Qty * i.CnvFact, @QtyPrec) --INSetup.DecPlQty)
				WHEN 'D'
				  THEN round(i.Qty / i.CnvFact, @QtyPrec) --INSetup.DecPlQty)
				ELSE i.Qty END
		END, 
		' ', ' ',  
       0,0,0,0,'',
       ' ',0,0,' ',' ',
       i.SiteID, GetDate(), i.LineRef, i.RefNbr, 
       'RFI', 
       i.TaskID, i.ExtCost/i.Qty, i.UnitDesc, ' ',' ',  
       0, 0,' ',' ',' ', 
       ' ' , i.WhseLoc, @IssueAcct, @IssueSub
  FROM INTran i JOIN Inventory v
                     ON i.InvtId = v.InvtId
 
 WHERE i.BatNbr = @BatNbr 
       AND i.RecordID = @RecordID 
       AND i.TranType = 'RP'
       AND i.Rlsed = 1
       
 
   
-- Insert the Project Allocated Lot/Serial Numbers for Issue Returns
INSERT InvProjAllocLot (AllocationLineID, AllocationLineRef, AllocationQty, CpnyID, Crtd_DateTime, 
       Crtd_Prog, Crtd_User, InvtID, LotSerNbr, LotSerRef, 
       LUpd_DateTime, LUpd_Prog, LUpd_User, MfgrLotSerNbr, ProjectID, 
       QtyRemainToIssue, S4Future01, S4Future02, S4Future03, S4Future04, 
       S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, 
       S4Future10, S4Future11, S4Future12, SiteID, SpecificCostID, 
       SrcDate, SrcLineRef, SrcNbr, SrcType, TaskID, 
       UnitDesc, User1, User2, User3, User4, 
       User5, User6, User7, User8, WhseLoc)
SELECT i.LineID, i.LineRef, l.qty, l.CpnyID, GetDate(), 
       (10400), @SolUser, l.InvtID, l.LotSerNbr, l.LotSerRef, 
       GetDate(), '10400', @SolUser, l.MfgrLotSerNbr, i.ProjectID, 
       l.Qty, ' ', ' ', 0, 0, 
       0, 0,' ', ' ',0, 
       0,' ',' ', l.SiteID, i.SpecificCostID, 
       i.TranDate, i.LineRef, i.RefNbr, 'RFI', i.TaskID, 
       v.stkunit, ' ',' ', 0, 0, 
       ' ',' ',' ', ' ', l.WhseLoc
  FROM INTran i JOIN LotSerT l
                  ON i.Batnbr = l.BatNbr
                 AND i.CpnyID = l.CpnyID
                 AND i.SiteID = l.SiteID
                 AND i.LineRef = l.INTranLineRef
				JOIN Inventory v
                  ON i.InvtID = v.InvtID
 WHERE i.Batnbr = @BatNbr
   AND i.RecordID = @RecordID
   AND i.TranType = 'RP'
   AND l.Rlsed = 1
 
