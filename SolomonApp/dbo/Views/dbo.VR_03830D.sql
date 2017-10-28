 

CREATE VIEW VR_03830D AS

Select
AdjgRefnbr = AdjgRefNbr,
AdjDiscAmt = SUM(adjdiscamt),
AdjAmt = Sum(AdjAmt),
AdjBkupWthld = Sum(AdjBkupWthld),
VendName = VendName,
VendorId = VendorID,
CpnyID = CpnyId,
CheckDate = CheckDate
From VR_03830D_Det
Group By AdjgRefNbr, VendorID, VendName, CpnyID, CheckDate
					 
