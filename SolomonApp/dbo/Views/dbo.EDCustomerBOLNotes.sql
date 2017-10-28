 

Create View EDCustomerBOLNotes As
Select A.BOLNbr, D.BOLNoteId From EDShipment A Inner Join EDShipTicket B On A.BOLNbr =
B.BOLNbr Inner Join SOShipHeader C On B.cpnyId = C.CpnyId And B.ShipperId = C.ShipperId
Inner Join CustomerEDI D On C.CustId = D.CustId


 
