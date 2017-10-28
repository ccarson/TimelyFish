

Create Procedure Update_ProjAlloc_POReturn_Lots 
       @SolUser VarChar(47), 
       @RcptNbr VarChar(15), 
       @LineRef VarChar(5),
       @OrigRcptNbr VarChar(15),
       @OrigRcptLineRef VarChar(5),
       @SrcType VarChar(3),
       @LotSerNbr Varchar(25),
       @LotSerRef VarChar(5),
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


    SELECT @OrigRcptType = CASE WHEN POOriginal = 'Y' THEN 'POR' ELSE 'PRR' END,
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
    UPDATE InvProjAllocLot 
       SET QtyRemainToIssue = round(QtyRemainToIssue - @QtyToReturn, @QtyPrec),
           LUpd_DateTime = GetDate(), LUpd_Prog = '10400', LUpd_User = @SolUser
     WHERE SrcNbr = @OrigRcptNbr 
       AND SrcLineRef = @OrigRcptLineRef
       AND SrcType = @SrcType
       AND LotSerNbr = @LotSerNbr
       AND LotSerRef = @LotSerRef

    --Delete project Allocated Records that goes to zero.     
    DELETE 
      FROM InvProjAllocLot 
     WHERE SrcNbr = @OrigRcptNbr 
       AND SrcLineRef = @OrigRcptLineRef 
       AND SrcType = @SrcType
       AND LotSerNbr = @LotSerNbr
       AND QtyRemainToIssue = 0

     INSERT INPrjAllocLotHist (
            AllocationLineID, AllocationLineRef, CpnyID, Crtd_DateTime, Crtd_Prog, 
            Crtd_User, InvtID, LotSerNbr, LotSerRef, MfgrLotSerNbr,                   
            Quantity, S4Future01, S4Future02, S4Future03, S4Future04, 
            S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, 
            S4Future10, S4Future11, S4Future12, SiteID, SpecificCostID, 
            SrcDate, SrcLineRef, SrcNbr, SrcType, TranSrcDate,  
            TranSrcLineRef, TranSrcNbr, TranSrcType, UnitDesc, User1,                    
            User2, User3, User4, User5, User6,  
            User7, User8, WhseLoc)
     SELECT @LineID, @LineRef, i.CpnyID, GetDate(), '10400', 
            @SolUser, i.InvtID, @LotSerNbr, @LotSerRef, ' ', 
            @QtyToReturn * -1, ' ', ' ', 0, 0, 
            0, 0, ' ', ' ', 0, 
            0, ' ', ' ', i.SiteID, ' ', 
            @OrigRcptDate, @OrigRcptLineRef, @OrigRcptNbr, @SrcType	, i.TranDate,  
            @LineRef, @RcptNbr, 'RFR', v.StkUnit, ' ', 
            ' ', 0, 0, ' ', ' ', 
            ' ', ' ', @WhseLoc
       FROM INTran i JOIN Inventory v
                       ON i.InvtID = v.InvtID
      WHERE i.Batnbr = @BatNbr
        AND i.RecordID = @RecordID
        AND i.TranType = 'II'

       
      UPDATE i
         SET QtyAllocated = ROUND((QtyAllocated - @QtyToReturn),@QtyPrec)
        FROM INPrjAllocationLot i 
       WHERE i.SrcType = 'RN'
         AND i.SrcNbr = @RcptNbr
         AND i.SrcLineRef = @LineRef
         AND i.LotSerNbr = @LotSernbr
         AND i.LotSerRef = @OrigLotSerRef 
         AND i.WhseLoc = @WhseLoc

      DELETE i
        FROM INPrjAllocationLot i 
       WHERE i.SrcType = 'RN'
         AND i.SrcNbr = @RcptNbr
         AND i.SrcLineRef = @LineRef
         AND i.LotSerNbr = @LotSernbr
         AND i.LotSerRef = @OrigLotSerRef 
         AND i.WhseLoc = @WhseLoc
         AND i.QtyAllocated <= 0


