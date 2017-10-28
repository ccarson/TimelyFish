
CREATE TRIGGER INPrjAllocHistory_Insert ON dbo.InvProjAlloc
FOR INSERT 
AS
Set NOCOUNT ON

INSERT INPrjAllocHistory (CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, InvtID, 
     OrdNbr, PerNbr, PO_QtyOrd, PO_UnitCost, PO_UOM, POLineRef,
     PONbr, ProjectID, Quantity, S4Future01, S4Future02, 
     S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, 
     S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, 
     SiteID, SrcDate, SrcLineRef, SrcNbr, SrcType, 
     TaskID, UnitCost, UnitDesc, User1, User2, 
     User3, User4, User5, User6, User7, 
     User8, WhseLoc, WIP_COGS_Acct, WIP_COGS_Sub)
SELECT i.CpnyID, i.Crtd_DateTime, i.Crtd_Prog, i.Crtd_User, i.InvtID, 
     i.OrdNbr, i.PerNbr, i.PO_QtyOrd, i.PO_UnitCost, i.PO_UOM, i.POLineRef, 
     i.PONbr, i.ProjectID, i.QtyAllocated, i.S4Future01, i.S4Future02, 
     i.S4Future03, i.S4Future04, i.S4Future05, i.S4Future06, i.S4Future07, 
     i.S4Future08, i.S4Future09, i.S4Future10, i.S4Future11, i.S4Future12, 
     i.SiteID, i.SrcDate, i.SrcLineRef, i.SrcNbr, i.SrcType, 
     i.TaskID, i.UnitCost, i.UnitDesc, i.User1, i.User2, 
     i.User3, i.User4, i.User5, i.User6, i.User7, 
     i.User8, i.WhseLoc, i.WIP_COGS_Acct, i.WIP_COGS_Sub
  FROM INSERTED i LEFT OUTER JOIN INPrjAllocHistory a
                    ON i.SrcType = a.SrcType 
                   AND i.SrcNbr = a.SrcNbr 
                   AND i.SrcLineRef = a.SrcLineRef
 WHERE a.InvtID IS NULL

