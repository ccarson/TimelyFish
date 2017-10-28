 


CREATE VIEW dbo.vp_03400_PO_VOQtyCost AS 


Select w.UserAddress,w.Batnbr, t.LineType, t.trantype,
qty = t.qty , 
curyppv = CONVERT(DEC(28,3),t.curyppv), 
ppv = CONVERT(DEC(28,3),t.ppv), 
tranamt = CONVERT(DEC(28,3),t.tranamt), 
curytranamt = CONVERT(DEC(28,3),t.curytranamt),
t.rcptnbr, t.rcptlineref

From APTran t 
     Join APDoc a
     on t.refnbr = a.refnbr
     And t.batnbr = a.batnbr 
     Join WrkRelease w
     On t.BatNbr = w.BatNbr
Where a.DocType <> 'VC'     
     

 
