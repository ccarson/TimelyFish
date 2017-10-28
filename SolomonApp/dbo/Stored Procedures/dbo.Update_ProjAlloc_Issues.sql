
Create Procedure Update_ProjAlloc_Issues
       @SolUser VarChar(47), 
       @LineRef VarChar(5),
       @QtyPrec	Int, 
       @CostPrec Int,  
       @Batnbr VarChar(10),
       @RecordID Integer,
       @QtyOnHand  Float

AS
DECLARE @OrigSrcNbr VarChar(15)
DECLARE @OrigSrcLineRef VarChar(5)
DECLARE @OrigSrcType VarChar(3)
DECLARE @OrigRcptDate SmallDateTime
DECLARE @PerEnt VarChar(6)
DECLARE @CpnyID VarChar(10)
DECLARE @TranDate SmallDateTime
DECLARE @LineID Int
DECLARE @QTYToIssue As Float
DECLARE @QTYAllocated As Float
DECLARE @ProjQtyToConsume As Float
DECLARE @ProjectID as VarChar(16)
DECLARE @TaskId As VarChar(32)
DECLARE @SiteId As VarChar(10)
DECLARE @Invtid As VarChar(30)
DECLARE @QtyDiff As Float
DECLARE @QtyAllocation As Float


Select @OrigSrcNbr = SrcNbr, @OrigSrcLineRef = SrcLineRef , @OrigSrcType = SrcType, @InvtId = InvtId, @projectID = projectID, @TaskID = TaskID, @SiteId = siteid, @CpnyID = CpnyID
       From Intran where 
       BatNbr = @BatNbr AND
       LineRef = @LineRef AND
       RecordId = @RecordID 
       


EXEC SumqtyRemainToIssue @InvtId, @ProjectID, @TaskID, @SiteID, @CpnyID, @QtyToIssue OUTPUT  
EXEC SumQtyAllocation  @InvtId, @ProjectID, @TaskID, @SiteID, @CpnyID, @QtyAllocated OUTPUT

set @ProjQtyToConsume = @QtyToIssue - (@QtyAllocated + @QtyOnHand)

  Select QtyRemainToIssue = ISNULL(@QtyToIssue,0) - ISNULL(@QtyAllocated,0)

	--Update Project Allocated Inventory for Issue
    UPDATE InvProjAlloc 
       SET QtyRemainToIssue = round(QtyRemainToIssue + @QtyOnHand, @QtyPrec),
           LUpd_DateTime = GetDate(), LUpd_Prog = '10400', LUpd_User = @SolUser
     WHERE SrcNbr = @OrigSrcNbr 
       AND SrcLineRef = @OrigSrcLineRef
       AND SrcType = @OrigSrcType

    --Delete project Allocated Records that goes to zero.     
    DELETE 
      FROM InvProjAlloc 
     WHERE SrcNbr = @OrigSrcNbr 
       AND SrcLineRef = @OrigSrcLineRef 
       AND SrcType = @OrigSrcType
       AND QtyRemainToIssue = 0

     --Audit Record of Project Allocation transaction
     INSERT INPrjAllocTranHist (
            ActualCost, CpnyID,  Crtd_DateTime, Crtd_Prog, 
            Crtd_User, PC_Status,PerNbr,                   
            Quantity,S4Future01, S4Future02, S4Future03, S4Future04, 
            S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, 
            S4Future10, S4Future11, S4Future12,SrcDate,
             SrcLineRef, SrcNbr, SrcType,
             TranSrcDate, TranSrcLineRef, TranSrcNbr, TranSrcType,  
             User1, User2, User3, User4, User5, User6, 
             User7, User8 )
      SELECT i.UnitCost,i.CpnyID, GetDate(), '10400', 
            @SolUser, '1',i.PerEnt,  
            @QtyOnHand,'', '', 0,0,
            0, 0, ' ', ' ', 0, 
            0, ' ', ' ', GetDate(),
            i.SrcLineRef, i.SrcNbr, i.Srctype,
            GetDate(), i.LineRef, i.RefNbr, 'ISS', 
            '','',0,0,'','',
            '',''
       FROM INTran i  
       WHERE i.Batnbr = @BatNbr
                        AND i.RecordID = @RecordID
                        AND i.TranType = 'II'
                        AND i.LineRef = @LineRef
                        AND i.SrcNbr <> ' '
        
    -- Pull QtyAllocated from SO or SH
 If @ProjQtyToConsume < 0 
    Begin
        set @ProjQtyToConsume = @ProjQtyToConsume * -1
        declare	Priority Cursor
	       for
	        select	QtyAllocated
	        from	InPrjAllocation
	        where	InvtID = @InvtID
	        and	    SiteID = @SiteID
	        and	    ProjectId = @ProjectId
            and     TaskId = @TaskId
            and     CpnyId = @CpnyID
            and     SrcType <> 'IS'
            Order By Srctype DESC, Priority 

 
        fetch next from Priority
	               into	@QtyAllocation

        while (@@Fetch_Status = 0 AND @ProjQtytoConsume <> 0)
	    begin
	        set @QtyDiff = @QtyAllocation - @ProjQtytoConsume
            If @QtyDiff > 0 
            Begin
                  Update Inprjallocation set QtyAllocated = @QtyDiff,
                           				LUpd_DateTime = GetDate(),
						                LUpd_Prog = '10020'
                   Where current of Priority
                    set  @ProjQtytoConsume = 0

            End
            Else
            Begin
                Delete Inprjallocation  Where current of Priority
            Set @ProjQtytoConsume =  @ProjQtytoConsume - @QtyAllocation
                If @ProjQtytoConsume <> 0 
                Begin
                   fetch next from Priority
	                     into  @QtyAllocation
                End
            End
                
          Close Priority
          Deallocate Priority
       End
   End
        
       

     --Update Project Allocated Inventory Lot/Serial Numbers 
     UPDATE p
        SET QtyRemainToIssue = round(p.QtyRemainToIssue + (l.Qty * l.InvtMult),@QtyPrec), 
            LUpd_DateTime = GetDate(), LUpd_Prog = '10400', LUpd_User = @SolUser
       FROM INTran i JOIN LotSerT l
                       ON i.Batnbr = l.BatNbr
                      AND i.CpnyID = l.CpnyID
                      AND i.SiteID = l.SiteID
                      AND i.LineRef = l.INTranLineRef
                     JOIN InvProjAllocLot p
                       ON l.LotSerNbr = p.LotSerNbr
                      AND l.InvtID = p.InvtID
                      AND l.SiteID = p.SiteID
                      AND l.WhseLoc = p.WhseLoc
      WHERE i.Batnbr = @BatNbr
        AND i.RecordID = @RecordID
        AND i.TranType = 'II'
        AND l.Rlsed = 1
        AND p.SrcNbr = @OrigSrcNbr
        AND p.SrcLineRef = @OrigSrcLineRef
        AND p.SrcType = @OrigSrcType

    --Delete project Allocated Lot/Serial Records that go to zero. 
     DELETE 
       FROM InvProjAllocLot 
      WHERE SrcNbr = @OrigSrcNbr 
        AND SrcLineRef = @OrigSrcLineRef 
        AND SrcType = @OrigSrcType
        AND QtyRemainToIssue = 0

	--Clear out the Project Allocated Inventory for the Issue of Project Inventory to Project.
     UPDATE p
        SET QtyAllocProjIN = round(p.QtyAllocProjIN + (l.Qty * l.InvtMult),@QtyPrec),  
            LUpd_DateTime = GetDate(), LUpd_Prog = '10400', LUpd_User = @SolUser
       FROM INTran i JOIN LotSerT l 
                       ON i.Batnbr = l.BatNbr
                      AND i.CpnyID = l.CpnyID
                      AND i.SiteID = l.SiteID
                      AND i.LineRef = l.INTranLineRef
                     JOIN LotSerMst p 
                       ON l.LotSerNbr = p.LotSerNbr
                      AND l.InvtID = p.InvtID
                      AND l.SiteID = p.SiteID
                      AND l.WhseLoc = p.WhseLoc
      WHERE i.Batnbr = @BatNbr
        AND i.RecordID = @RecordID
        AND i.TranType = 'II'
        AND l.Rlsed = 1
        AND i.SrcNbr <> ' '

     --Audit Record of Project Allocated Purchase Order Lot/Serial numbers being Returned back to the Vendor.
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
     SELECT i.LineID, i.LineRef, l.CpnyID, GetDate(), '10400', 
            @SolUser, l.InvtID, l.LotSerNbr, l.LotSerRef, l.MfgrLotSerNbr, 
            l.Qty * l.InvtMult, ' ', ' ', 0, 0, 
            0, 0, ' ', ' ', 0, 
            0, ' ', ' ', l.SiteID, ' ', 
            i.SrcDate, @OrigSrcLineRef, @OrigSrcNbr, @OrigSrcType, i.TranDate,  
            @LineRef, i.RefNbr, 'ISS', v.StkUnit, ' ', 
            ' ', 0, 0, ' ', ' ', 
            ' ', ' ', l.WhseLoc
       FROM INTran i JOIN LotSerT l
                       ON i.Batnbr = l.BatNbr
                      AND i.CpnyID = l.CpnyID
                      AND i.SiteID = l.SiteID
                      AND i.LineRef = l.INTranLineRef
                     JOIN Inventory v
                       ON i.InvtID = v.InvtID
      WHERE i.Batnbr = @BatNbr
        AND i.RecordID = @RecordID
        AND i.TranType = 'II'
        AND i.SrcNbr <> ' '

	--Delete the allocation records for the Issues transaction that are issueing Project Allocated Inventory.
      DELETE i
        FROM INPrjAllocation i JOIN INTran t
                                 ON i.SrcNbr = t.RefNbr
                                AND i.SrcLineRef = t.LineRef
                                AND i.SrcType = 'IS'
       WHERE t.Batnbr = @BatNbr
         AND t.RecordID = @RecordID
         AND t.TranType = 'II'
         AND t.LineRef = @LineRef
         AND t.SrcNbr <> ' '

      DELETE i
        FROM INPrjAllocationLot i JOIN INTran t
                                    ON i.SrcNbr = t.RefNbr
                                   AND i.SrcLineRef = t.LineRef
                                   AND i.SrcType = 'IS'
       WHERE t.Batnbr = @BatNbr
         AND t.RecordID = @RecordID
         AND t.TranType = 'II'
         AND t.LineRef = @LineRef
         AND t.SrcNbr <> ' '


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_ProjAlloc_Issues] TO [MSDSL]
    AS [dbo];

