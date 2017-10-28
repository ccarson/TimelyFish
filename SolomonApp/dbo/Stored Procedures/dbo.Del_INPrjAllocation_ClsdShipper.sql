 CREATE PROC Del_INPrjAllocation_ClsdShipper
	@ShipperID	varchar(15),
	@CpnyID		varchar(10)

AS

  DELETE INPrjAllocation
   WHERE SrcNbr = @ShipperID
     AND CpnyID = @CpnyID
     AND SrcType = 'SH'

  DELETE INPrjAllocationLot
   WHERE SrcNbr = @ShipperID
     AND CpnyID = @CpnyID
     AND SrcType = 'SH'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Del_INPrjAllocation_ClsdShipper] TO [MSDSL]
    AS [dbo];

