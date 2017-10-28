 Create Proc EDShipment_SelectReprint As
Select BOLNbr From EDShipment Where BOLState = 'S' And ShipStatus = 'C' And SendASN = 1


