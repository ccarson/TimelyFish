CREATE VIEW pTempGLRecon 
AS
Select 'Abra' As Type, CpnyID, RTrim(Acct) AS Acct, RTrim(Sub) As Sub, Sum(CrAmt) As Credit, Sum(DrAmt) As Debit
From GLTran Where BatNbr IN ('012224','012226','012228','012229','012280','012281')
Group by CpnyID, Acct, Sub
--Order by CpnyID, Acct, Sub

