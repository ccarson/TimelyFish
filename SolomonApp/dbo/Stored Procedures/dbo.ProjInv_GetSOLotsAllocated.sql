Create Proc ProjInv_GetSOLotsAllocated
   @OrdNbr    Varchar(15),
   @LineRef   Varchar(5),
   @CpnyID    VarChar(10),
   @ProjectID Varchar(16),
   @TaskID    Varchar(32)

AS
SELECT i.*
  FROM INPrjAllocationLot i
 WHERE i.SrcType = 'SO'
   AND i.SrcNbr = @OrdNbr
   AND i.SrcLineRef = @LineRef
   AND i.ProjectID = @ProjectID
   AND i.TaskID = @TaskID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_GetSOLotsAllocated] TO [MSDSL]
    AS [dbo];

