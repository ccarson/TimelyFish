Create proc SumRemainQtyAllocatedLot @parm1 varchar(30), @parm2 varchar (16), @parm3 varchar (32), @parm4 varchar (10), @Parm5 varchar(25), @Parm6 varchar(10), @Parm7 varchar(10), @Parm8 varchar(15)  as
		Set NoCount ON
        Declare @QtyToIssue As float,
                @QtyAllocate As float

EXEC SumqtyRemainToIssueLot @Parm1, @Parm2, @Parm3, @Parm4, @parm5, @parm6, @parm7, @QtyToIssue OUTPUT  
EXEC SumtotalQtyAllocationLot @Parm1, @parm2, @Parm3, @Parm4, @Parm5, @parm6, @parm7, @parm8, @QtyAllocate OUTPUT
Select QtyRemainToIssue = ISNULL(@QtyToIssue,0) - ISNULL(@QtyAllocate,0)
