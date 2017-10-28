 CREATE PROCEDURE EDShipticket_Cpnyid_ShipperId  @parm1 varchar(10),@parm2 varchar(15) AS
Select * from EDshipTicket Where
Cpnyid like @parm1 and ShipperID like @parm2


