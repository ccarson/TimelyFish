 CREATE PROCEDURE EDShipTick_ShipNbr @parm1 varchar(10) , @parm2 varchar(15)  AS
Select * from EDShipTicket where CpnyID = @parm1 and ShipperID like @parm2 order by CpnyID, ShipperID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipTick_ShipNbr] TO [MSDSL]
    AS [dbo];

