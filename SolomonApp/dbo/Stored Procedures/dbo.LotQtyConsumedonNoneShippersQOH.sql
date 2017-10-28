
CREATE proc LotQtyConsumedonNoneShippersQOH @InvtId varchar(30), @SiteId varchar (16), @WhseLoc varchar(10), 
                                            @ProjectId varchar (16), @TaskID varchar (32), @LotSerNbr varchar (25) AS

  SELECT OthQtyAllocQOH = ISNULL(SUM(InPrjAllocationLot.QtyAllocated),0)
    FROM InPrjAllocationLot with (nolock)
   WHERE Invtid = @Invtid 
     AND SiteID = @SiteId  
     AND WhseLoc like @WhseLoc
     AND ProjectID = @ProjectID
     AND TaskId = @TaskID
     AND SrcType <> 'SH'
     AND LotSerNbr like @LotSerNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotQtyConsumedonNoneShippersQOH] TO [MSDSL]
    AS [dbo];

