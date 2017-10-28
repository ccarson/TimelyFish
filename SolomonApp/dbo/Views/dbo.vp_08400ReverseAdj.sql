 

CREATE VIEW vp_08400ReverseAdj AS
SELECT w.UserAddress, b.PerEnt, b.PerPost, 
ARAcct = COALESCE(LTRIM(c.ARAcct),s.ARAcct), 
ARSub = COALESCE(LTRIM(c.ARSub),s.ARSub), 
s.DiscAcct, s.DiscSub, s.DfltSBWOAcct, s.DfltSBWOSub, s.DfltSCWOAcct, s.DfltSCWOSub,
paCpnyId = pa.Cpnyid, paBankAcct = pa.BankAcct, paBankSub = pa.BankSub, paBatNbr = pa.BatNbr, pa.OrigDocAmt, pa.CuryOrigDocAmt,
pa.CuryId, pa.CuryRateType, pa.CuryRate, pa.CuryMultDiv, pa.CuryEffDate, 
invCpnyId = inv.Cpnyid, invBankAcct = inv.BankAcct, invBankSub = inv.BankSub, invCuryId = inv.CuryId, invPC_Status = inv.PC_Status, CustName=c.name, rp.* 
FROM
WrkRelease w 
INNER JOIN Batch b ON b.BatNbr = w.BatNbr AND b.Module = w.Module AND b.EditScrnNbr = '08240'
INNER JOIN ARAdjust rp ON rp.S4Future11 = w.BatNbr AND w.Module = 'AR'
INNER JOIN ARDoc inv ON inv.CustId = rp.CustId AND 
			inv.RefNbr = rp.AdjdRefNbr AND 
			inv.DocType = rp.AdjdDocType 
INNER JOIN ARDoc pa ON	pa.CustId = rp.CustId  AND
			pa.doctype = rp.adjgdoctype AND
			pa.refnbr = rp.adjgrefnbr
INNER JOIN Customer c ON rp.CustId = c.CustId, ARSetup s (nolock)

 
