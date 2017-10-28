
Create proc SumFloatAllocation  @parm1 varchar (30), @parm2 varchar (16), @parm3 varchar (32), @parm4 varchar (10), @parm5 varchar(10), @QtyAllocated INT OUTPUT  as
select @QtyAllocated = ISNULL(sum(i.QtyAllocated),0) 
  from INPrjAllocation i LEFT JOIN INPrjAllocationLot t 
                            ON i.SrcNbr = t.SrcNbr AND
                               i.SrcLineRef = t.SrcLineref AND
                               i.SrcType = t.SrcType
where
i.Invtid = @Parm1 AND
i.ProjectID = @Parm2  AND
i.TaskId = @parm3 AND
i.SiteId = @parm4 AND
i.CpnyId = @parm5 AND
i.srctype in ('SO') AND
t.SrcNbr is NULL

GO
GRANT CONTROL
    ON OBJECT::[dbo].[SumFloatAllocation] TO [MSDSL]
    AS [dbo];

