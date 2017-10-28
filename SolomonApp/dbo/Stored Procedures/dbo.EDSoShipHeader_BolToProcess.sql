 CREATE PROCEDURE EDSoShipHeader_BolToProcess @parm1 varchar(20) AS
select soshipheader.* from soshipheader,edshipticket where edshipticket.bolnbr = @parm1 and edshipticket.shipperid = soshipheader.shipperid and edshipticket.cpnyid = soshipheader.cpnyid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSoShipHeader_BolToProcess] TO [MSDSL]
    AS [dbo];

