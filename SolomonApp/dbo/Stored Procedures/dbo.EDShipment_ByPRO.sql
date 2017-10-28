 CREATE Proc EDShipment_ByPRO @PRO varchar(30) As
Select * From EDShipment Where PRO = @PRO Order By BOLNbr


