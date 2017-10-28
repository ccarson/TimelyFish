 CREATE PROCEDURE EDShipVia_SCAC_Routing @CpnyID varchar(10), @SCAC varchar(5), @Routing as varchar(50) AS
Declare @ShipViaID  as varchar(15)
Select @ShipViaID = ShipViaId from Shipvia (NOLOCK) where @CpnyID = cpnyid and SCAC = @SCAC
if isnull(@ShipViaID,'~') = '~'
   begin
      Select @ShipViaID = ShipViaId from Shipvia (NOLOCK) where @CpnyID = cpnyid and EDIViaCode = left(@Routing,20)
   End
Select @ShipViaId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipVia_SCAC_Routing] TO [MSDSL]
    AS [dbo];

