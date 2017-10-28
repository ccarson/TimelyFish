 Create Proc EDConfirmShipperChk @CpnyId varchar(10), @ShipperId varchar(10), @CustId varchar(15) As
-- Checks to see wether or not a shipper can be confirmed.  Returns 0 if it is OK to confirm
-- the shipper; 1 if the customer requires containers that haven't yet been built or 2 if the
-- the shipviaid on this shipper does not match with the others on its bill of lading.

Declare @Active smallint
Declare @ContainerCount int
Declare @ContTrackLevel varchar(10)
Declare @ShipViaCount int
Declare @Result smallint

-- initialize
Set @Result = 0

Select @Active = IsNull(Active,0) From ANSetup
If @Active = 0 -- would be true if ASN is not installed or inactive
  Goto ExitProc

-- check to make sure that the shipviaid's on all shippers for a BOL match.
Select @ShipViaCount = Count(Distinct A.ShipViaId) From SOShipHeader A Inner Join EDShipTicket B
 On A.CpnyId = B.CpnyId And A.ShipperId = B.ShipperId Where B.BOLNbr = (Select BOLNbr From
 EDShipTicket Where CpnyId = @CpnyId And ShipperId = @ShipperId)
If @ShipViaCount > 1
  Set @Result = 2

If @Result = 0 Begin
  Select @ContTrackLevel = ContTrackLevel From CustomerEDI Where CustId = @CustId
  If @ContTrackLevel = 'TCO' Begin -- track container headers only.
    Select @ContainerCount = Count(*) From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId
    If @ContainerCount = 0
      Set @Result = 1
  End
  If @ContTrackLevel = 'TCD' Begin -- track container details.
    Select @ContainerCount = Count(*) From EDContainerDet Where CpnyId = @CpnyId And ShipperId = @ShipperId
    If @ContainerCount = 0
      Set @Result = 1
  End
End

ExitProc:
-- return flag
Select @Result



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDConfirmShipperChk] TO [MSDSL]
    AS [dbo];

