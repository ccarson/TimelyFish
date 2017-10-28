 CREATE PROCEDURE EDShipment_Delete @BolNbr varchar(20) AS
Delete from EDShipment where bolnbr = @BolNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_Delete] TO [MSDSL]
    AS [dbo];

