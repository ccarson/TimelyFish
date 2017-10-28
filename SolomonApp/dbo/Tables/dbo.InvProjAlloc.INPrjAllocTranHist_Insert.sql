
CREATE TRIGGER INPrjAllocTranHist_Insert ON dbo.InvProjAlloc
FOR INSERT 
AS
Set NOCOUNT ON

INSERT INPrjAllocTranHist (ActualCost, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, PC_Status, 
     PerNbr, Quantity, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, 
     S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, 
     S4Future11, S4Future12, SrcDate, SrcLineRef, SrcNbr, 
     SrcType, TranSrcDate, TranSrcLineRef, TranSrcNbr, TranSrcType, 
     User1, User2, User3, User4, User5, 
     User6, User7, User8)
SELECT 0, i.CpnyID,i.Crtd_DateTime, i.Crtd_Prog, i.Crtd_User, ' ', i.PerNbr, i.QtyAllocated, 
     i.S4Future01, i.S4Future02, i.S4Future03, i.S4Future04, i.S4Future05, 
     i.S4Future06, i.S4Future07, i.S4Future08, i.S4Future09, i.S4Future10, 
     i.S4Future11, i.S4Future12, i.SrcDate, i.SrcLineRef, i.SrcNbr, 
     i.SrcType, '1/1/1900',' ' , ' ', 'INT', 
     i.User1, i.User2, i.User3, i.User4, i.User5, 
     i.User6, i.User7, i.User8
  FROM INSERTED i LEFT OUTER JOIN INPrjAllocTranHist a
                    ON i.SrcType = a.SrcType 
                   AND i.SrcNbr = a.SrcNbr 
                   AND i.SrcLineRef = a.SrcLineRef
 WHERE a.TranSrcType is null


