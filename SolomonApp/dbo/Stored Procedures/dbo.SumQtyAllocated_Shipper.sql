
Create proc SumQtyAllocated_Shipper @parm1 varchar(30), @parm2 varchar (16), @parm3 varchar (32), @parm4 varchar (10), @Parm5 varchar(10), @Parm6 varchar(10)  as
        Declare @QtyToIssue As float,
                @QtyAllocate As float

EXEC SumqtyRemainToIssue_Shipper @Parm1, @Parm2, @Parm3, @Parm4,@parm5, @parm6, @QtyToIssue OUTPUT  
EXEC SumQtyAllocation_Shipper @Parm1, @parm2, @Parm3, @Parm4, @Parm5, @parm6, @QtyAllocate OUTPUT
Select QtyRemainToIssue = ISNULL(@QtyToIssue,0) - ISNULL(@QtyAllocate,0)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[SumQtyAllocated_Shipper] TO [MSDSL]
    AS [dbo];

