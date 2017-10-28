 

CREATE View EDBOLShipViaId As
Select Distinct A.BOLNbr, B.CpnyId, A.ViaCode 
From EDShipment A Inner Join EDShipTicket B On A.BOLNbr = B.BOLNbr

 
