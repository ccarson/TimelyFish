 Create Procedure EDWrkContPrint_SingAccessNbr
	@AccessNbr Integer,
	@ShipperID VarChar(30)
As
Select * From EDWrkContPrint Where AccessNbr = @AccessNbr and ShipperID Like @ShipperID Order By AccessNbr, ShipperID


