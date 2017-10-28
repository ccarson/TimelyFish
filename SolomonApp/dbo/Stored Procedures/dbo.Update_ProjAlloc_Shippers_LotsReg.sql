
Create Procedure Update_ProjAlloc_Shippers_LotsReg 
       @SolUser VarChar(47),        
       @SrcNbr VarChar(15),          
       @SrcLineRef VarChar(5),       
       @SrcType VarChar(3),          
       @QtyPrec	Int, 
       @CostPrec Int,  
       @Batnbr VarChar(10),          
       @RecordID Integer,            
       @QtyToConsume Float,          
       @ShipperID varchar(15),       
       @ShipperLineRef VarChar(5),   
       @SrcDate date

AS

    --Update Project Allocated Inventory for the Return of Project Allocated Purchase For detail lines
    UPDATE InvProjAlloc 
       SET QtyRemainToIssue = round(QtyRemainToIssue - @QtyToConsume, @QtyPrec),
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
     
    if (SELECT COUNT(*) 
          FROM INPrjAllocTranHist h WITH(NOLOCK) 
         WHERE h.SrcLineRef  = @SrcLineRef 
           AND h.SrcNbr = @SrcNbr
           AND h.SrcType = @SrcType
           AND h.TranSrcLineRef  = @ShipperLineRef
           AND h.TranSrcNbr = @ShipperID
           AND h.TranSrcType = 'SHP') = 0
	
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
                  '1', i.PerEnt, @QtyToConsume * -1, ' ',                   
                  ' ', 0, 0, 0, 0,  
                  ' ', ' ', 0, 0, ' ', 
                  ' ', @SrcDate, @SrcLineRef, @SrcNbr, @SrcType, 
                  i.TranDate, @ShipperLineRef, @ShipperID, 'SHP', ' ', 
                  ' ', 0, 0, ' ', ' ', 
                  ' ', ' '
             FROM INTran i JOIN Inventory v
                             ON i.InvtID = v.InvtID
            WHERE i.Batnbr = @BatNbr
              AND i.RecordID = @RecordID
              AND i.TranType = 'IN'
	    END
        ELSE
	    BEGIN
  
            UPDATE h SET Quantity = h.Quantity + @QtyToConsume * -1
              FROM INPrjAllocTranHist h
             WHERE h.SrcLineRef  = @SrcLineRef 
               AND h.SrcNbr = @SrcNbr
               AND h.SrcType = @SrcType
               AND h.TranSrcLineRef  = @ShipperLineRef
               AND h.TranSrcNbr = @ShipperID
               AND h.TranSrcType = 'SHP'
         END

      UPDATE i
         SET QtyAllocated = ROUND((QtyAllocated - @QtyToConsume),@QtyPrec)
        FROM INPrjAllocation i 
       WHERE i.SrcNbr = @ShipperID
         AND i.SrcLineRef = @ShipperLineRef
         AND i.SrcType = 'SH'

      UPDATE s 
         SET QtyAllocProjIN = CASE WHEN CONVERT(DEC(28,9),s.QtyAllocProjIN) - CONVERT(DEC(28,9),@QtyToConsume) < 0 
                                     THEN 0 
                                   ELSE CONVERT(DEC(28,9),s.QtyAllocProjIN) - CONVERT(DEC(28,9),@QtyToConsume) END,
                                   
             PrjINQtyShipNotInv = CASE WHEN CONVERT(DEC(28,9),s.PrjINQtyShipNotInv) - CONVERT(DEC(28,9),@QtyToConsume) < 0 
                                         THEN 0 
                                       ELSE CONVERT(DEC(28,9),s.PrjINQtyShipNotInv) - CONVERT(DEC(28,9),@QtyToConsume) END
        FROM INPrjAllocation i JOIN ItemSite s
                               ON i.InvtID = s.InvtID
                              AND i.SiteID = s.SiteID
       WHERE i.SrcNbr = @ShipperID
         AND i.SrcLineRef = @ShipperLineRef
         AND i.SrcType = 'SH'

      UPDATE l 
         SET QtyAllocProjIN = CASE WHEN CONVERT(DEC(28,9),l.QtyAllocProjIN) - CONVERT(DEC(28,9),@QtyToConsume) < 0 
                                     THEN 0 
                                   ELSE CONVERT(DEC(28,9),l.QtyAllocProjIN) - CONVERT(DEC(28,9),@QtyToConsume) END,
                                   
             PrjINQtyShipNotInv = CASE WHEN CONVERT(DEC(28,9),l.PrjINQtyShipNotInv) - CONVERT(DEC(28,9),@QtyToConsume) < 0 
                                         THEN 0 
                                       ELSE CONVERT(DEC(28,9),l.PrjINQtyShipNotInv) - CONVERT(DEC(28,9),@QtyToConsume) END
        FROM INPrjAllocation i JOIN Location l
                                 ON i.InvtID = l.InvtID
                                AND i.SiteID = l.SiteID
                                AND i.WhseLoc = l.WhseLoc
       WHERE i.SrcNbr = @ShipperID
         AND i.SrcLineRef = @ShipperLineRef
         AND i.SrcType = 'SH'

      DELETE i
        FROM INPrjAllocation i 
       WHERE i.SrcType = 'SH'
         AND i.SrcNbr = @ShipperID
         AND i.SrcLineRef = @ShipperLineRef
         AND i.QtyAllocated <= 0

