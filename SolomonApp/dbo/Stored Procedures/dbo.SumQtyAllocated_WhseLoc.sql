
CREATE proc SumQtyAllocated_WhseLoc @InvtId varchar(30), @SiteId varchar (16), @ProjectId varchar (16), @TaskID varchar (32), @CpnyID varchar(10), @WhseLoc varchar(10)   as
        Declare @QtyToIssue As float,
                @QtyAllocate As float

EXEC SumqtyRemainToIssue_WhseLoc @InvtiD, @SiteId, @ProjectID, @TaskID, @CpnyID, @WhseLoc,  @QtyToIssue OUTPUT  
EXEC SumQtyAllocation_WhseLoc @InvtID, @SiteID, @ProjectID, @TaskID, @CpnyID, @WhseLoc,  @QtyAllocate OUTPUT
Select QtyRemainToIssue = ISNULL(@QtyToIssue,0) - ISNULL(@QtyAllocate,0)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SumQtyAllocated_WhseLoc] TO [MSDSL]
    AS [dbo];

