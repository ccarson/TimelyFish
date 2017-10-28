 Create Proc EDShipment_Close @BOLNbr varchar(20) As
Update EDShipment Set ShipStatus = 'C', BOLState = 'S', SendASN = 0 Where BOLNbr = @BOLNbr


