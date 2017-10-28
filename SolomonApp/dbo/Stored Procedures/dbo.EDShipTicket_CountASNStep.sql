 Create Proc EDShipTicket_CountASNStep @BOLNbr varchar(20) As
Select Count(*) From EDShipTicket A, SOShipHeader B Where A.CpnyId = B.CpnyId And A.ShipperId = B.ShipperId
And A.BOLNbr = @BOLNBr And B.NextFunctionId = '5040200'


