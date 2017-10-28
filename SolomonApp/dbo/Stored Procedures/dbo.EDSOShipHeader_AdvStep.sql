 Create Proc EDSOShipHeader_AdvStep @CpnyId varchar(10), @ShipperId varchar(15) As
Select CpnyId, ShipperId, SOTypeId, OrdNbr, SiteId, AdminHold, CreditHold,
  CreditChk, Status, CustId, NextFunctionId From SOShipHeader Where CpnyId = @CpnyId And
  ShipperId = @ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeader_AdvStep] TO [MSDSL]
    AS [dbo];

