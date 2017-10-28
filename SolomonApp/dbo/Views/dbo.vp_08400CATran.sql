 

CREATE VIEW vp_08400CATran AS
SELECT DISTINCT b.BatNbr, t.BankCpnyId, t.BankAcct, t.BankSub, CustID = t.PayeeId, TranType = 'PA', 
RefNbr = CASE WHEN c.EditScrnNbr ='20500' THEN t.BatNbr+t.Module ELSE t.RefNbr END
FROM CaTran t
INNER JOIN EntryTyp y on y.EntryId = t.EntryId and y.UpdARMod = 1
INNER JOIN Batch c on c.BatNbr = t.BatNbr and c.Module ='CA'
INNER JOIN Batch b on b.OrigBatNbr = t.BatNbr and b.JrnlType = c.Module and b.Module = 'AR'
WHERE t.DrCr='C' 


 
