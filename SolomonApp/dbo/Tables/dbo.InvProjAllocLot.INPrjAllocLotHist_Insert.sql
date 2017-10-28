
CREATE TRIGGER INPrjAllocLotHist_Insert ON dbo.InvProjAllocLot
FOR INSERT 
AS
Set NOCOUNT ON

INSERT INPrjAllocLotHist (AllocationLineID, AllocationLineRef, CpnyID, Crtd_DateTime, Crtd_Prog,  
     Crtd_User, InvtID, LotSerNbr, LotSerRef, MfgrLotSerNbr, Quantity, 
     S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
     S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
     S4Future11, S4Future12, SiteId, SpecificCostID, SrcDate, SrcLineRef,
     SrcNbr, SrcType, TranSrcDate, TranSrcLineRef, TranSrcNbr,
     TranSrcType, UnitDesc, User1, User2, User3, User4,
     User5, User6, User7, User8, Whseloc)
SELECT i.AllocationLineID, i.AllocationLineRef, i.CpnyID, i.Crtd_DateTime, i.Crtd_Prog, 
     i.Crtd_User, i.InvtID, i.LotSerNbr, i.LotSerRef, i.MfgrLotSerNbr, i.AllocationQty,
     i.S4Future01, i.S4Future02, i.S4Future03, i.S4Future04, i.S4Future05,
     i.S4Future06, i.S4Future07, i.S4Future08, i.S4Future09, i.S4Future10,
     i.S4Future11, i.S4Future12, i.SiteID, i.SpecificCostID, i.SrcDate, i.SrcLineRef,
     i.SrcNbr, i.SrcType, '1/1/1900', ' ', ' ',  
     'INT', i.UnitDesc, i.User1, i.User2, i.User3, i.User4, 
     i.User5, i.User6, i.User7, i.User8, i.Whseloc
  FROM INSERTED i LEFT OUTER JOIN INPrjAllocLotHist a
                    ON i.SrcType = a.SrcType 
                   AND i.SrcNbr = a.SrcNbr 
                   AND i.SrcLineRef = a.SrcLineRef
                   AND i.LotSerNbr = a.LotSerNbr
                   AND i.LotSerRef = a.LotSerRef
 WHERE a.TranSrcType is null


