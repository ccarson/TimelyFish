 CREATE PROCEDURE EDContainer_Update_BolNbr @BolNbr varchar(20), @ShipperID varchar(15), @CpnyID varchar(10)  AS

update EDContainer set bolnbr = @BolNbr where ShipperID = @ShipperID and CpnyID = @CpnyID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_Update_BolNbr] TO [MSDSL]
    AS [dbo];

