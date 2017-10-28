 Create Proc EDShipTicket_Nav @BOLNbr varchar(20), @ShipperID Varchar(15), @CpnyId VarChar(10) As
Select * From EDShipTicket Where BOLNbr = @BOLNbr AND ShipperID LIKE  @shipperID AND CpnyId LIKE @CpnyId


