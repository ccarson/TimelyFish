
CREATE proc SumQtyAllocatedSO @parm1 varchar(30), @parm2 varchar (16), @parm3 varchar (32), @parm4 varchar (10), @Parm5 varchar(10), 
                             @QtyAvail  Float OutPut as 
        Declare @TotalQtyNotIssued As float,
                @QtyAllocateISSH As float,
                @QtyAllocateLots As float

EXEC SumqtyRemainToIssue @Parm1, @Parm2, @Parm3, @Parm4,@parm5,  @TotalQtyNotIssued OUTPUT  
EXEC SumQtyAllocationISSH @Parm1, @parm2, @Parm3, @Parm4, @Parm5, @QtyAllocateISSH OUTPUT
EXEC SumQtyAllocationSOLOTS @Parm1, @parm2, @Parm3, @Parm4, @Parm5, @QtyAllocateLots OUTPUT
Select @QtyAvail = ISNULL(@TotalQtyNotIssued,0) - ISNULL(@QtyAllocateISSH,0) -  ISNULL(@QtyAllocateLots,0) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[SumQtyAllocatedSO] TO [MSDSL]
    AS [dbo];

