
Create Procedure Update_ProjAlloc_POReturn1
       @SolUser VarChar(47), 
       @RcptNbr VarChar(15), 
       @LineRef VarChar(5),
       @SrcNbr Varchar(15),
       @SrcLineRef Varchar(5),
       @SrcType VarChar(3),
       @QtyPrec	Int, 
       @CostPrec Int,  
       @Batnbr VarChar(10),
       @RecordID Integer,
       @QtyToReturn  Float  
AS
DECLARE @OrigRcptNbr VarChar(15)
DECLARE @OrigRcptLineRef VarChar(5)
DECLARE @OrigRcptType VarChar(3)
DECLARE @OrigRcptDate SmallDateTime
DECLARE @PerEnt VarChar(6)
DECLARE @CpnyID VarChar(10)
DECLARE @TranDate SmallDateTime
DECLARE @LineID Int
DECLARE @ReturnQty float

SELECT @ReturnQty = @QtyToReturn

SELECT @OrigRcptNbr = RcptNbrOrig, @OrigRcptLineRef = RcptLineRefOrig, 
       @OrigRcptType = CASE WHEN PurchaseType = 'PS' and POOriginal = 'Y' THEN 'GSO'
                            WHEN POOriginal = 'Y' THEN 'POR'
                            ELSE 'PRR'
                       END,
       @PerEnt = PerPost, @CpnyID = CpnyID, @TranDate = TranDate, @LineID = LineID
  FROM POTran
WHERE RcptNbr = @RcptNbr
  AND LineRef = @LineRef
  AND TranType = 'X' -- Return
  AND PurchaseType IN ('PI','PS') --Goods for Project Inventory, and Goods for Project Sales Order

If @OrigRcptNbr IS NOT NULL
BEGIN
	--Get Original Receipt Date
	SELECT @OrigRcptDate = SrcDate
      FROM InPrjAllocHistory WITH(NOLOCK)
     WHERE SrcType = @OrigRcptType
       AND SrcNbr = @OrigRcptNbr
       AND SrcLineRef = @OrigRcptLineRef


    --If the Project Allocated Inventory has been unallocated in the Project Inventory. 
    -- Only need to relieve the remaining quantity of Project Inventory.
    SELECT @ReturnQty = CASE WHEN i.SrcType IS NULL THEN 0
                             ELSE CASE WHEN @QtyToReturn * -1 <= i.QtyRemainToIssue THEN @QtyToReturn
                                       ELSE i.QtyRemainToIssue * -1
                                  END
	                     END
	  FROM InvProjAlloc i
	 WHERE SrcNbr = @SrcNbr 
       AND SrcLineRef = @SrcLineRef
       AND SrcType = @SrcType
       
    --Update Project Allocated Inventory for the Return of Project Allocated Purchase For detail lines
    UPDATE InvProjAlloc 
       SET QtyRemainToIssue = round(QtyRemainToIssue + @ReturnQty, @QtyPrec),
           LUpd_DateTime = GetDate(), LUpd_Prog = '10400', LUpd_User = @SolUser
	 WHERE SrcNbr = @SrcNbr 
       AND SrcLineRef = @SrcLineRef
       AND SrcType = @SrcType

    --Delete project Allocated Records that goes to zero.     
    DELETE 
      FROM InvProjAlloc 
     WHERE SrcNbr = @SrcNbr 
       AND SrcLineRef = @SrcLineRef 
       AND SrcType = @SrcType
       AND QtyRemainToIssue = 0

     --Insert Audit Record of Project Allocated Purchase Order being Returned back to the Vendor.
     INSERT INPrjAllocTranHist ( 
            ActualCost,CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,       
            PC_Status, PerNbr, Quantity, S4Future01,                   
            S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,  
            S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, 
            S4Future12, SrcDate, SrcLineRef, SrcNbr, SrcType, 
            TranSrcDate, TranSrcLineRef, TranSrcNbr, TranSrcType, User1, 
            User2, User3, User4, User5, User6, 
            User7, User8)
     SELECT 0, @CpnyID, GetDate(), '10400', @SolUser,       
            '1', @PerEnt, @ReturnQty, ' ',                   
            ' ', 0, 0, 0, 0,  
            ' ', ' ', 0, 0, ' ', 
            ' ', @OrigRcptDate, @SrcLineRef, @SrcNbr, @SrcType, 
            @TranDate, @LineRef, @RcptNbr, 'RFR', ' ', 
            ' ', 0, 0, ' ', ' ', 
            ' ', ' '

    IF @OrigRcptType = 'GSO'
    BEGIN
        UPDATE i
           SET QtyAllocated = ROUND((QtyAllocated + @ReturnQty), @QtyPrec)
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

        --If there wasn't any more project allocated inventory to return, then the remaining amount of the return is coming from regular inventory.
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
        SET QtyAllocated = ROUND((QtyAllocated + @ReturnQty),@QtyPrec)
       FROM INPrjAllocation i JOIN INTran t
                                ON i.SrcNbr = t.RefNbr
                               AND i.SrcLineRef = t.LineRef
                               AND i.SrcType = 'RN'
     WHERE t.Batnbr = @BatNbr
       AND t.RecordID = @RecordID
       AND t.TranType = 'II'
       AND t.LineRef = @LineRef
       AND t.RcptNbr <> ' '

     --If there wasn't any more project allocated inventory to return, then the remaining amount of the return is coming from regular inventory.
     DELETE i
       FROM INPrjAllocation i JOIN INTran t
                                ON i.SrcNbr = t.RefNbr
                               AND i.SrcLineRef = t.LineRef
                               AND i.SrcType = 'RN'
     WHERE t.Batnbr = @BatNbr
       AND t.RecordID = @RecordID
       AND t.TranType = 'II'
       AND t.LineRef = @LineRef
       AND t.RcptNbr <> ' '
       AND i.QtyAllocated <= 0
    END
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_ProjAlloc_POReturn1] TO [MSDSL]
    AS [dbo];

