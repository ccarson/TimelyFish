
CREATE proc SumQtyAllocation_WhseLoc @InvtId varchar(30), @SiteId varchar (16), @ProjectId varchar (16), @TaskID varchar (32), @CpnyID varchar(10), @WhseLoc varchar(10), @QtyAllocated INT OUTPUT  as
select @QtyAllocated = ISNULL(sum(InPrjAllocation.QtyAllocated),0)
    from InPrjAllocation with (nolock)
where
Invtid = @Invtid AND
ProjectID = @SiteID  AND
TaskId = @ProjectID AND
SiteId = @TaskID AND
CpnyId = @CpnyID AND
WhseLoc = @WhseLoc AND
SrcType <> 'SO'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SumQtyAllocation_WhseLoc] TO [MSDSL]
    AS [dbo];

