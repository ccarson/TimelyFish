 CREATE PROC Del_INPrjAllocation_ClsdSO
	@OrdNbr		varchar(15),
	@CpnyID		varchar(10)

AS

  DELETE INPrjAllocation
   WHERE SrcNbr = @OrdNbr
     AND CpnyID = @CpnyID
     AND SrcType = 'SO'

  DELETE INPrjAllocationLot
   WHERE SrcNbr = @OrdNbr
     AND CpnyID = @CpnyID
     AND SrcType = 'SO'

