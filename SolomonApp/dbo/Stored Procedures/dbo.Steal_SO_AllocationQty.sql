
CREATE Procedure Steal_SO_AllocationQty
       @ProjectID varchar(16),
       @TaskID VarChar(32),
       @InvtId  VarChar(30),
       @SiteId  VarChar(10),
       @CpnyId  VarChar(10),
       @Requested_Qty float,
       @SOLineRef VarChar(5),
       @SOOrdNbr  VarChar(15)
     
  

AS
DECLARE @QTYToIssue As Float
DECLARE @QTYAllocated As Float
DECLARE @QtyNeed As Float
Declare @QtyAvail As Float 
Declare @QtyFLoatDemand As Float
Declare @QtyFound Float
Declare @RecFetched as VarChar(1) 

set @RecFetched = 'Y'


-- First see if the Qty is already allocated to the SO, if so, then convert the SO allocation to a SH allocation
select	@QtyFound = i.Qtyallocated
  from INPrjAllocation i
 Where 	    i.InvtID = @InvtID
	        and	    i.SiteID = @SiteID
	        and	    i.ProjectId = @ProjectId
            and     i.TaskId = @TaskId
            and     i.CpnyId = @CpnyID
            and     i.SrcType = 'SO'
            and     i.SrcNbr = @SOOrdNbr
            and     i.SrcLineref = @SOLineRef

If @QtyFound > @Requested_Qty 
   Begin
       Update Inprjallocation  set QtyAllocated = QtyAllocated - @Requested_Qty,
                		LUpd_DateTime = GetDate(),
				        LUpd_Prog = '40400'
        Where InvtID = @InvtID
	        and	SiteID = @SiteID
	        and	ProjectId = @ProjectId
            and TaskId = @TaskId
            and CpnyId = @CpnyID
            and SrcType = 'SO'
            and SrcNbr = @SOOrdNbr
            and SrcLineref = @SOLineRef

       set @QtyFound = @Requested_Qty
   End
   Else IF  @QtyFound <= @Requested_Qty And @QtyFound <> 0
   Begin
        Delete from Inprjallocation 
         Where InvtID = @InvtID
	        and	SiteID = @SiteID
	        and ProjectId = @ProjectId
            and TaskId = @TaskId
            and CpnyId = @CpnyID
            and SrcType = 'SO'
            and SrcNbr = @SOOrdNbr
            and SrcLineref = @SOLineRef
   End

-- Not enough qty was not allocated to SO, see of there is unallocated Project Inventory to use
-- Since any that was allocated to the corresponding SO was just deleted, need to calc avail - floating demand to get qty found.
if @QtyFound < @Requested_Qty
Begin
	exec SumQtyAllocatedSO @Invtid, @ProjectID, @TaskID, @SiteId, @CpnyID, @QtyAvail output
	exec SumFloatAllocation  @Invtid, @ProjectID, @TaskID, @SiteId, @CpnyID, @QtyFLoatDemand output
	Set @QtyFound = @QtyAvail - @QtyFLoatDemand
    If @QtyFound > @Requested_Qty
        Set @QtyFound = @Requested_Qty
    else
    Begin
        --not enough unallocated so set up cursor for looking thru soft allocations.
        declare	Priority Cursor
	       for
	        select	i.Qtyallocated
	        from INPrjAllocation i LEFT JOIN INPrjAllocationLot t 
					   ON i.SrcNbr = t.SrcNbr AND
	   				   i.SrcLineRef = t.SrcLineref
	        where	i.InvtID = @InvtID
	        and	    i.SiteID = @SiteID
	        and	    i.ProjectId = @ProjectId
            and     i.TaskId = @TaskId
            and     i.CpnyId = @CpnyID
            and     i.SrcType = 'SO'
            and     t.SrcNBr Is NULL
            Order By i.Priority DESC
         fetch next from Priority
	          into	@QTYAllocated
         If @@Fetch_status <> 0 
         Begin
             Set @RecFetched = 'N'
         end
    End
End

-- if still not enough was avail, try to get qty from SO allocations (soft allocatios)
While @RecFetched = 'Y' AND @QtyFound <> @Requested_Qty
Begin    
      set @QtyNeed = @Requested_Qty - @QtyFound
      If @QTYAllocated > @QtyNeed 
      Begin
               Update Inprjallocation set QtyAllocated = QtyAllocated - @QtyNeed,
                        		LUpd_DateTime = GetDate(),
						        LUpd_Prog = '40400'
                       Where current of Priority
               set @QtyFound = @Requested_Qty

       End
       Else If @QTYAllocated <= @QtyNeed
       Begin
                Delete Inprjallocation  Where current of Priority
                set @QtyFound = @QtyFound + @QTYAllocated 
                fetch next from Priority
                  into  @QTYAllocated
                If @@Fetch_status <> 0 
                  set @RecFetched = 'N'
       End
   
End
Close Priority
Deallocate Priority
INSERT INPrjAllocation (CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, InvtID, 
                                   LUpd_DateTime, LUpd_Prog, LUpd_User, OrdNbr, Priority, 
                                   ProjectID, QtyAllocated, S4Future01, S4Future02, S4Future03, 
                                   S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, 
                                   S4Future09, S4Future10, S4Future11, S4Future12, SiteID, 
                                   SrcLineRef, SrcNbr, SrcType, TaskID, UnitDesc, 
                                   User1, User2, User3, User4, User5, 
                                   User6, User7, User8, WhseLoc)
                            SELECT s.CpnyID, GetDate(), '40400', '', @InvtId, 
                                   GetDate(), '40400', '', @SOOrdNbr, '', 
                                   @ProjectID, @QtyFound, '', '', 0, 
                                   0, 0, 0, '', '', 
                                   0, 0, '', '', @SiteId, 
                                   @SOLineRef,@SOOrdNbr , 'SO', @TaskID, v.StkUnit, 
                                   '','',0,0,'',
                                   '','','', ''
                                   FROM  SOLine s JOIN Inventory v WITH(NOLOCK)
                                        ON s.InvtID = v.InvtID
                                        WHERE s.InvtId = @InvtId
                                         AND s.LineRef = @SOLineRef
                                         AND s.OrdNbr = @SOOrdNbr
                                         AND s.CpnyID = @CpnyID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Steal_SO_AllocationQty] TO [MSDSL]
    AS [dbo];

