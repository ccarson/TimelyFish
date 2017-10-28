
Create Procedure ProjInv_AutoFTT_ProjINAlloc 
       @RefNbr VarChar(15)

AS

     SELECT DISTINCT i.UnAllocSrcNbr, i.UNAllocSrcType
       FROM INProjAllocTran i WITH(NOLOCK)
      WHERE i.RefNbr = @RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_AutoFTT_ProjINAlloc] TO [MSDSL]
    AS [dbo];

