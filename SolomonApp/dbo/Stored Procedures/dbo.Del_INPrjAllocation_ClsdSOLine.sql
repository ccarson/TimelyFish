 CREATE PROC Del_INPrjAllocation_ClsdSOLine
	@OrdNbr		varchar(15),
	@CpnyID		varchar(10),
	@LineRef	varchar(5)

AS

  DELETE INPrjAllocation
   WHERE SrcNbr = @OrdNbr
     AND SrcLineRef = @LineRef
     AND CpnyID = @CpnyID
     AND SrcType = 'SO'

  DELETE INPrjAllocationLot
   WHERE SrcNbr = @OrdNbr
     AND SrcLineRef = @LineRef
     AND CpnyID = @CpnyID
     AND SrcType = 'SO'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Del_INPrjAllocation_ClsdSOLine] TO [MSDSL]
    AS [dbo];

