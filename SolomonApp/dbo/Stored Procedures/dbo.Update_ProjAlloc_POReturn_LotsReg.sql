
Create Procedure Update_ProjAlloc_POReturn_LotsReg 
       @SolUser VarChar(47), 
       @RcptNbr VarChar(15), 
       @LineRef VarChar(5),
       @OrigRcptNbr VarChar(15),
       @OrigRcptLineRef VarChar(5),
       @SrcType VarChar(3),
       @QtyPrec	Int, 
       @CostPrec Int,  
       @Batnbr VarChar(10),
       @RecordID Integer,
       @QtyToReturn  Float,
       @WhseLoc VarChar(10),
       @OrigLotSerRef VarChar(5)
AS
--'DECLARE @OrigRcptNbr VarChar(15)
DECLARE @OrigRcptType VarChar(3)
DECLARE @OrigRcptDate SmallDateTime
DECLARE @PerEnt VarChar(6)
DECLARE @CpnyID VarChar(10)
DECLARE @TranDate SmallDateTime
DECLARE @LineID Int

SELECT @OrigRcptType = CASE WHEN PurchaseType = 'PS' and POOriginal = 'Y' THEN 'GSO'
                            WHEN POOriginal = 'Y' THEN 'POR'
                            ELSE 'PRR'
                       END,
            @PerEnt = PerPost, @CpnyID = CpnyID, @TranDate = TranDate, @LineID = LineID
      FROM POTran
     WHERE RcptNbr = @RcptNbr
       AND LineRef = @LineRef
       AND TranType = 'X' -- Return
       AND PurchaseType IN ('PI','PS') --Goods for Project Inventory, and Goods for Project Sales Order

	--Get Original Receipt Date
	SELECT @OrigRcptDate = SrcDate
      FROM InPrjAllocHistory WITH(NOLOCK)
     WHERE SrcType = @SrcType
       AND SrcNbr = @OrigRcptNbr
       AND SrcLineRef = @OrigRcptLineRef
    
    --Update Project Allocated Inventory for the Return of Project Allocated Purchase For detail lines
    UPDATE InvProjAlloc 
       SET QtyRemainToIssue = round(QtyRemainToIssue - @QtyToReturn, @QtyPrec),
           LUpd_DateTime = GetDate(), LUpd_Prog = '10400', LUpd_User = @SolUser
     WHERE SrcNbr = @OrigRcptNbr 
       AND SrcLineRef = @OrigRcptLineRef
       AND SrcType = @SrcType

    --Delete project Allocated Records that goes to zero.     
    DELETE 
      FROM InvProjAlloc
     WHERE SrcNbr = @OrigRcptNbr 
       AND SrcLineRef = @OrigRcptLineRef 
       AND SrcType = @SrcType
       AND QtyRemainToIssue = 0
    
     --Insert Audit Record of Project Allocated Purchase Order being Returned back to the Vendor.
     
    if (SELECT COUNT(*) 
          FROM INPrjAllocTranHist h WITH(NOLOCK) 
         WHERE h.SrcLineRef  = @OrigRcptLineRef 
           AND h.SrcNbr  = @OrigRcptNbr
           AND h.SrcType = @SrcType
           AND h.TranSrcLineRef  = @LineRef
           AND h.TranSrcNbr = @RcptNbr
           AND h.TranSrcType = 'RFR') = 0
	
	    BEGIN     
           INSERT INPrjAllocTranHist ( 
                  ActualCost,CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,       
                  PC_Status, PerNbr, Quantity, S4Future01,                   
                  S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,  
                  S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, 
                  S4Future12, SrcDate, SrcLineRef, SrcNbr, SrcType, 
                  TranSrcDate, TranSrcLineRef, TranSrcNbr, TranSrcType, User1, 
                  User2, User3, User4, User5, User6, 
                  User7, User8)
           SELECT 0, i.CpnyID, GetDate(), '10400', @SolUser,       
                  '1', @PerEnt, @QtyToReturn * -1, ' ',                   
                  ' ', 0, 0, 0, 0,  
                  ' ', ' ', 0, 0, ' ', 
                  ' ', @OrigRcptDate, @OrigRcptLineRef, @OrigRcptNbr, @SrcType, 
                  i.TranDate, @LineRef, @RcptNbr, 'RFR', ' ', 
                  ' ', 0, 0, ' ', ' ', 
                  ' ', ' '
             FROM INTran i JOIN Inventory v
                             ON i.InvtID = v.InvtID
            WHERE i.Batnbr = @BatNbr
              AND i.RecordID = @RecordID
              AND i.TranType = 'II'
	      END
            ELSE
	    BEGIN
  
           UPDATE h SET Quantity = h.Quantity + @QtyToReturn * -1
             FROM INPrjAllocTranHist h
            WHERE h.SrcLineRef  = @OrigRcptLineRef
              AND h.SrcNbr  = @OrigRcptNbr
              AND h.SrcType = @SrcType
              AND h.TranSrcLineRef  = @LineRef
              AND h.TranSrcNbr = @RcptNbr
              AND h.TranSrcType = 'RFR'
    END

IF @OrigRcptType = 'GSO'
BEGIN
    UPDATE i
       SET QtyAllocated = ROUND((QtyAllocated - @QtyToReturn), @QtyPrec)
      FROM INPrjAllocation i
           JOIN INTran t
                JOIN POTran pot
                     JOIN POAlloc poa
                       ON poa.PONbr = pot.PONbr
                      AND poa.POLineRef = pot.POLineRef
                  ON pot.RcptNbr = t.RefNbr
                 AND pot.LineRef = t.LineRef
             ON t.Batnbr = @BatNbr
            AND t.RecordID = @RecordID
            AND t.TranType = 'II'
            AND t.LineRef = @LineRef
            AND t.RcptNbr <> ' '
     WHERE i.SrcNbr = poa.SOOrdNbr
       AND i.SrcLineRef = poa.SOLineRef
       AND i.SrcType = 'SO'

    DELETE i
      FROM INPrjAllocation i
           JOIN INTran t
                JOIN POTran pot
                     JOIN POAlloc poa
                       ON poa.PONbr = pot.PONbr
                      AND poa.POLineRef = pot.POLineRef
                  ON pot.RcptNbr = t.RefNbr
                 AND pot.LineRef = t.LineRef
             ON t.Batnbr = @BatNbr
            AND t.RecordID = @RecordID
            AND t.TranType = 'II'
            AND t.LineRef = @LineRef
            AND t.RcptNbr <> ' '
     WHERE i.SrcNbr = poa.SOOrdNbr
       AND i.SrcLineRef = poa.SOLineRef
       AND i.SrcType = 'SO'
       AND i.QtyAllocated <= 0
END
ELSE
BEGIN
      UPDATE i
         SET QtyAllocated = ROUND((QtyAllocated - @QtyToReturn),@QtyPrec)
        FROM INPrjAllocation i 
       WHERE i.SrcType = 'RN'
         AND i.SrcNbr = @RcptNbr
         AND i.SrcLineRef = @LineRef
         AND i.WhseLoc = @WhseLoc

      DELETE i
        FROM INPrjAllocation i 
       WHERE i.SrcType = 'RN'
         AND i.SrcNbr = @RcptNbr
         AND i.SrcLineRef = @LineRef
         AND i.WhseLoc = @WhseLoc
         AND i.QtyAllocated <= 0
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_ProjAlloc_POReturn_LotsReg] TO [MSDSL]
    AS [dbo];

