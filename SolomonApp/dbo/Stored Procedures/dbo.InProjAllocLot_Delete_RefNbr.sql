
 Create Proc InProjAllocLot_Delete_RefNbr  @parm1 varchar (15) as
    Delete from InProjAllocLot where RefNbr = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[InProjAllocLot_Delete_RefNbr] TO [MSDSL]
    AS [dbo];

