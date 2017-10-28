 CREATE PROCEDURE EDShipTick_Company @parm1 varchar(10) AS
Select * from EDShipTicket where CpnyID like @parm1 order by CpnyID DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipTick_Company] TO [MSDSL]
    AS [dbo];

