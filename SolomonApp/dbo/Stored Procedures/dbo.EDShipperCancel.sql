 CREATE Proc EDShipperCancel @CpnyId varchar(10), @ShipperId varchar(15) As
Declare @BOLNbr varchar(20)
Declare @ShipTicketCount int
Declare @EDShipSetupCount smallint
Select @EDShipSetupCount = Count(*) From ANSetup
If @EDShipSetupCount > 0
  Begin
  Begin Transaction
  Select @BOLNbr = BOLNbr From EDShipTIcket Where CpnyId = @CpnyId And ShipperId = @ShipperId
  Delete From EDShipTicket Where CpnyId = @CpnyId And ShipperId = @ShipperId
  Delete From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId
  Delete From EDContainerDet Where CpnyId = @CpnyId And ShipperId = @ShipperId
  Select @ShipTicketCount = Count(*) From EDShipTicket Where BOLNbr = @BOLNbr
  If @ShipTicketCount = 0
    Begin
    Delete From EDShipment Where BOLNbr = @BOLNbr
    End
  Else
    Begin
    Exec EDRecalcBOLInfo @BOLNbr
  End
  Update EDSOShipHeader Set SendViaEDI = 0 Where CpnyId = @CpnyId And ShipperId = @ShipperId
  Commit Transaction
End



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipperCancel] TO [MSDSL]
    AS [dbo];

