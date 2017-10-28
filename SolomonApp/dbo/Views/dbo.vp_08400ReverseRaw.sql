 

CREATE VIEW vp_08400ReverseRaw AS
/*PA*/
SELECT
v.UserAddress, v.S4Future11, v.PerEnt, v.PerPost, 
DrCpnyId = v.paCpnyId, DrAcct = v.ARAcct, DrSub = v.ARSub, CrCpnyId = v.paCpnyId, CrAcct = COALESCE(t.BankAcct,v.paBankAcct), CrSub = COALESCE(t.BankSub,v.paBankSub), Invert=0,
CuryTranAmt = v.CuryOrigDocAmt, TranAmt = v.OrigDocAmt, v.CuryId, v.CuryRateType, v.CuryRate, v.CuryMultDiv, v.CuryEffDate,
TranType = v.AdjgDocType, RefNbr = v.AdjgRefNbr, v.CustId, v.CustName, TranClass = 'P'
FROM
(SELECT UserAddress, S4Future11, AdjgDocType, AdjgRefNbr, CustId, PerEnt = MAX(PerEnt), PerPost = MAX(PerPost), ARAcct=MAX(ARAcct), ARSub=MAX(ARSub), CustName=MAX(CustName), 
paBatNbr = MAX(paBatNbr), paCpnyId = MAX(paCpnyId), paBankAcct = MAX(paBankAcct), paBankSub = MAX(paBankSub), CuryId = MAX(CuryId), CuryRateType =MAX(CuryRateType), CuryRate = MAX(CuryRate), CuryMultDiv=MAX(CuryMultDiv), CuryEffDate=MAX(CuryEffDate), OrigDocAmt = MAX(OrigDocAmt), CuryOrigDocAmt = MAX(CuryOrigDocAmt) 
FROM vp_08400ReverseAdj WHERE AdjgDocType='PA' AND S4Future12 IN ('NS','RP') GROUP BY UserAddress, S4Future11, AdjgDocType, AdjgRefNbr, CustId) v
LEFT JOIN vp_08400CATran t ON t.BankCpnyId = v.paCpnyId AND
			t.BatNbr = v.paBatNbr AND
			t.CustId = v.CustId AND
			t.TranType = v.AdjgDocType AND
			t.RefNbr = v.AdjgRefNbr 

UNION ALL
/*Application*/
SELECT
v.UserAddress, v.S4Future11, v.PerEnt, v.PerPost,
v.invCpnyId, v.invBankAcct, v.invBankSub, v.paCpnyId, v.ARAcct, v.ARSub, 0,
v.CuryAdjgAmt, v.AdjAmt, v.CuryId, v.CuryRateType, v.CuryRate, v.CuryMultDiv, v.CuryEffDate,
v.AdjgDocType, v.AdjgRefNbr, v.CustId, v.CustName,'A'
FROM
vp_08400ReverseAdj v
WHERE v.invCpnyId<>v.paCpnyId OR v.InvBankAcct<>v.ARAcct OR v.InvBankSub<>v.ARSub

UNION ALL
/*Discount*/
SELECT
v.UserAddress, v.S4Future11, v.PerEnt, v.PerPost, 
v.invCpnyId,  v.invBankAcct, v.invBankSub, v.invCpnyId, v.DiscAcct, v.DiscSub, 0,
v.CuryAdjgDiscAmt, v.AdjDiscAmt, v.CuryId, v.CuryRateType, v.CuryRate, v.CuryMultDiv, v.CuryEffDate,
v.AdjgDocType,v.AdjgRefNbr, v.CustId, v.CustName,'D'
FROM
vp_08400ReverseAdj v
WHERE v.AdjDiscAmt<>0

UNION ALL
/*RGOL*/
SELECT
v.UserAddress, v.S4Future11, v.PerEnt, v.PerPost,
v.paCpnyId, v.ARAcct, v.ARSub, v.paCpnyId,
CASE WHEN v.AdjgDocType = 'CM' THEN
  CASE WHEN v.CuryRGOLAmt>0 THEN c.RealGainAcct ELSE c.RealLossAcct END ELSE	
  CASE WHEN v.CuryRGOLAmt>0 THEN c.RealLossAcct ELSE c.RealGainAcct END END,
CASE WHEN v.AdjgDocType = 'CM' THEN
  CASE WHEN v.CuryRGOLAmt>0 THEN c.RealGainSub ELSE c.RealLossSub END ELSE	
  CASE WHEN v.CuryRGOLAmt>0 THEN c.RealLossSub ELSE c.RealGainSub END END,
CASE WHEN v.AdjgDocType = 'CM' THEN 
  CASE WHEN v.CuryRGOLAmt > 0 THEN 1 ELSE 0 END ELSE
  CASE WHEN v.CuryRGOLAmt > 0 THEN 0 ELSE 1 END END,
0, ABS(v.CuryRGOLAmt), v.CuryId, v.CuryRateType, v.CuryRate, v.CuryMultDiv, v.CuryEffDate,
v.AdjgDocType, v.AdjgRefNbr, v.CustId, v.CustName,
CASE WHEN v.AdjgDocType = 'CM' THEN 
  CASE WHEN v.CuryRGOLAmt > 0 THEN 'I' ELSE 'O' END ELSE
  CASE WHEN v.CuryRGOLAmt > 0 THEN 'L' ELSE 'G' END END
FROM
vp_08400ReverseAdj v
INNER JOIN Currncy c ON v.invCuryId = c.CuryId 
WHERE v.CuryRGOLAmt<>0

UNION ALL
/*SB*/
SELECT
v.UserAddress, v.S4Future11, v.PerEnt, v.PerPost,
v.invCpnyId,v.invBankAcct, v.invBankSub, v.invCpnyId, v.DfltSBWOAcct, v.DfltSBWOSub,0,
j.CuryAdjgAmt, j.AdjAmt, COALESCE(sb.CuryId,v.CuryId), COALESCE(sb.CuryRateType,v.CuryRateType), COALESCE(sb.CuryRate,v.CuryRate), COALESCE(sb.CuryMultDiv,v.CuryMultDiv),COALESCE(sb.CuryEffDate,v.CuryEffDate),
j.AdjgDocType, j.AdjgRefNbr, v.CustId, v.CustName, TranClass='B'
FROM
(SELECT UserAddress, S4Future11, AdjdDocType, AdjdRefNbr, AdjgDocType, AdjgRefNbr, CustId, invCpnyId = MAX(invCpnyId), invBankAcct = MAX(invBankAcct), invBankSub = MAX(invBankSub), CuryId = MAX(CuryId), CuryRateType =MAX(CuryRateType), CuryRate = MAX(CuryRate), CuryMultDiv=MAX(CuryMultDiv), CuryEffDate=MAX(CuryEffDate),
DfltSBWOAcct = MAX(DfltSBWOAcct), DfltSBWOSub = MAX(DfltSBWOSub), CustName =MAX(CustName), PerEnt = MAX(PerEnt), PerPost = MAX(PerPost) FROM vp_08400ReverseAdj GROUP BY UserAddress, S4Future11, AdjdDocType, AdjdRefNbr, AdjgDocType, AdjgRefNbr,CustId) v
INNER JOIN ARAdjust j ON j.AdjdRefNbr = v.AdjdRefNbr AND 
			j.AdjdDocType = v.AdjdDocType AND 
			j.CustId = v.CustId AND
			j.AdjgDocType = 'SB' AND
			j.S4Future11 = ' '
INNER JOIN Currncy c ON c.CuryId = v.CuryId
LEFT JOIN ARDoc sb ON 	sb.BatNbr = j.AdjBatNbr AND
			sb.CustId = j.CustId AND
			sb.DocType = j.AdjgDocType AND
			sb.RefNbr = j.AdjgRefNbr

UNION ALL
/*SC*/
SELECT
v.UserAddress, v.S4Future11, v.PerEnt, v.PerPost,
v.paCpnyId, v.DfltSCWOAcct, v.DfltSCWOSub, v.paCpnyId, v.ARAcct, v.ARSub, 0,
j.CuryAdjgAmt, j.AdjAmt, v.CuryId, v.CuryRateType, v.CuryRate, v.CuryMultDiv, v.CuryEffDate,
j.AdjgDocType, j.AdjgRefNbr, v.CustId, v.CustName,'C'
FROM
(SELECT UserAddress, S4Future11, AdjgDocType, AdjgRefNbr, CustId, paCpnyId = MAX(paCpnyId), CuryId = MAX(CuryId), CuryRateType =MAX(CuryRateType), CuryRate = MAX(CuryRate), CuryMultDiv=MAX(CuryMultDiv), CuryEffDate=MAX(CuryEffDate), CustName = MAX(CustName), PerEnt = MAX(PerEnt), PerPost = MAX(PerPost), DfltSCWOAcct = MAX(DfltSCWOAcct), DfltSCWOSub = MAX(DfltSCWOSub), ARAcct=MAX(ARAcct), ARSub=MAX(ARSub) FROM vp_08400ReverseAdj GROUP BY UserAddress, S4Future11, AdjgDocType, AdjgRefNbr, CustId) v
INNER JOIN ARAdjust j ON j.AdjdRefNbr = v.AdjgRefNbr AND 
			j.AdjdDocType = v.AdjgDocType AND 
			j.CustId = v.CustId AND
			j.AdjgDocType = 'SC' AND
			j.S4Future11 = ' '


 
