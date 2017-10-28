 

CREATE VIEW vp_08400ReverseBal AS
/*Debit Doc Balances*/
SELECT v.UserAddress, v. S4Future12, v.CustId, DocType = v.AdjdDocType, RefNbr = v.AdjdRefNbr,
DocBal=v.AdjAmt+v.AdjDiscAmt, CuryDocBal = v.CuryAdjdAmt+v.CuryAdjdDiscAmt, DiscBal = v.AdjDiscAmt, CuryDiscBal = v.CuryAdjdDiscAmt, RGOLAmt = 0, DiscApplAmt = 0, CuryDiscApplAmt = 0
FROM vp_08400ReverseAdj v

UNION ALL
SELECT v.UserAddress,v. S4Future12, j.CustId, j.AdjdDocType, j.AdjdRefNbr,
j.AdjAmt, j.CuryAdjdAmt, 0, 0, 0, 0, 0
FROM
(SELECT DISTINCT UserAddress, S4Future12, CustId, AdjdDocType, AdjdRefNbr FROM vp_08400ReverseAdj) v 
INNER JOIN ARAdjust j ON j.CustId = v.CustId AND j.AdjdDocType = v.AdjdDocType AND j.AdjdRefNbr = v.AdjdRefNbr AND j.AdjgDocType ='SB' AND j.S4Future11 =' '

/*Credit Doc Balances*/
UNION ALL
SELECT v.UserAddress,v. S4Future12, v.CustId, v.AdjgDocType, v.AdjgRefNbr,
v.AdjAmt - v.CuryRGOLAmt, v.CuryAdjgAmt, 0, 0, v.CuryRGOLAmt, -v.AdjDiscAmt, -v.CuryAdjgDiscAmt
FROM vp_08400ReverseAdj v

UNION ALL
SELECT v.UserAddress,v. S4Future12, v.CustId, v.AdjgDocType, v.AdjgRefNbr,
j.AdjAmt, j.CuryAdjdAmt, 0, 0, 0, 0, 0
FROM
(SELECT DISTINCT UserAddress, S4Future12, CustId, AdjgDocType, AdjgRefNbr FROM vp_08400ReverseAdj) v
INNER JOIN ARAdjust j ON j.CustId = v.CustId AND j.AdjdDocType = v.AdjgDocType AND j.AdjdRefNbr = v.AdjgRefNbr AND j.AdjgDocType ='SC' AND j.S4Future11 =' '


 
