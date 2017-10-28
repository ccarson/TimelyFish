 Create Proc EDShipper_AdvStep @NextFunctionId varchar(8), @NextFunctionClass varchar(4), @CpnyId varchar(10), @ShipperId varchar(15)  As
Update SoShipHeader Set NextFunctionId = @NextFunctionID, NextFunctionClass = @NextFunctionClass
  Where CpnyId = @CpnyId And ShipperId = @ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipper_AdvStep] TO [MSDSL]
    AS [dbo];

