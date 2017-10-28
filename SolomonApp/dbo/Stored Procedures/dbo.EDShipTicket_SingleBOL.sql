 CREATE PROCEDURE EDShipTicket_SingleBOL @parm1 varchar(20), @parm2 varchar(10), @parm3 varchar(15)  AS
Select * from EDShipTicket where BOLNbr = @parm1 and CpnyID like @parm2 and ShipperID like @parm3 order by BOLNbr, CpnyID, ShipperID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipTicket_SingleBOL] TO [MSDSL]
    AS [dbo];

