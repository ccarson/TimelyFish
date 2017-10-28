 CREATE PROCEDURE EDShipTicket_All_ByCpnyID AS
Select * from EDShipTicket order by CpnyID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipTicket_All_ByCpnyID] TO [MSDSL]
    AS [dbo];

