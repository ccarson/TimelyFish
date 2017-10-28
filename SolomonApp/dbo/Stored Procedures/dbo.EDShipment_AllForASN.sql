 CREATE PROCEDURE EDShipment_AllForASN AS
select * from EDShipment where bolnbr in (Select distinct(edshipticket.bolnbr) from EDShipTicket,SOShipHeader where edshipticket.Shipperid = soshipheader.shipperid and edshipticket.cpnyid = soshipheader.cpnyid and soshipheader.nextfunctionid = '5040200')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_AllForASN] TO [MSDSL]
    AS [dbo];

