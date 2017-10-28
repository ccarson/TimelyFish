
CREATE proc SumQtyAllocation  @parm1 varchar (30), @parm2 varchar (16), @parm3 varchar (32), @parm4 varchar (10), @parm5 varchar(10), @QtyAllocated INT OUTPUT  as
select @QtyAllocated = ISNULL(sum(InPrjAllocation.QtyAllocated),0)
    from InPrjAllocation with (nolock)
where
Invtid = @Parm1 AND
ProjectID = @Parm2  AND
TaskId = @parm3 AND
SiteId = @parm4 AND
CpnyId = @parm5

