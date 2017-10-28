 /****** Object:  Stored Procedure dbo.EDSOShipHeader_all    Script Date: 5/28/99 1:17:45 PM ******/
CREATE PROCEDURE EDSOShipHeader_AllDMG @ShipperId varchar( 15 ), @CpnyId varchar( 10 ) AS
Select * From EDSOShipHeader Where CpnyId = @Cpnyid
and ShipperId = @ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeader_AllDMG] TO [MSDSL]
    AS [dbo];

