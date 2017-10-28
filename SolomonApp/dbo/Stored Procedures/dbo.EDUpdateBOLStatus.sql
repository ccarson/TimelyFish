 CREATE PROCEDURE EDUpdateBOLStatus @BOLNbr varchar(20), @NewStatus varchar(1), @ShipperId varchar(15), @CpnyId varchar(10)  AS
Declare @CountBadStatus smallint
Declare @ShipStatus varchar(1)
Select @ShipStatus = ShipStatus from EDShipment where BOLNbr = @BOLNbr
If @ShipStatus = 'S'
  Begin
 If @NewStatus = 'H'
                        Begin
  Update EDShipment Set ShipStatus = 'H' where BOLNbr = @BOLNbr
            End
              Else
  If @NewStatus = 'S'
--*****FIND OUT IF THERE ARE ANY OTHER STATUS THAT WOULD CONSTITUTE A BAD SHIPPER
   select @CountBadStatus = count(*) from EDshipticket, SOShipHeader where EDshipticket.bolnbr = @BOLNBR and EDShipTicket.ShipperId = SOShipHeader.ShipperId and  EDShipTicket.CpnyId = SOShipHeader.CpnyId and SOShipHeader.ShipperId <> @ShipperId and SOShipHeader.cpnyid <> @CpnyId and SOShipHeader.AdminHold = 0
    If @CountBadStatus = 0
    Update EDShipment set ShipStatus = @NewStatus where Bolnbr = @BOLNbr
 End




GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDUpdateBOLStatus] TO [MSDSL]
    AS [dbo];

