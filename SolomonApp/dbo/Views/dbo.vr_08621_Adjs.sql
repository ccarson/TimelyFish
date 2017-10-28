 

CREATE VIEW vr_08621_Adjs AS

SELECT	Recordid, AdjdRefNbr, AdjdDocType, CustID, AdjgRefNbr,
	AdjgDocType=CASE WHEN CuryAdjdAmt<0 AND S4Future12<>'' THEN S4Future12 ELSE AdjgDocType END,
	AdjgDocDate, PerAppl, CuryAdjdAmt, CuryAdjdDiscAmt, AdjAmt, AdjDiscAmt, RowType='A',
	DocType=AdjgDocType
FROM	ARAdjust

UNION ALL	

SELECT	-1, RefNbr, DocType, CustID, RefNbr,
	DocType,
	NULL, ' ', NULL, NULL, NULL, NULL, 'D',
	DocType
FROM	ARDoc
 WHERE Rlsed = 1 


 
