 CREATE PROCEDURE EDShipTicket_Count_BOL @BolNbr varchar(20) AS
Select Count(*) from EDShipTicket where bolnbr = @BolNbr


