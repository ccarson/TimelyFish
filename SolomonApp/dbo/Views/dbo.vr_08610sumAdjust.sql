 

Create view vr_08610sumAdjust AS 


select v.CpnyID, v.custid, v.doctype, v.refnbr, 

Curyid = 	Min(v.curyid),
CuryOrigDocAmt =Min(v.curyorigdocamt), 
DocDate = 	Min(v.docdate), 
DueDate = 	Min(v.DueDate),
OrigDocAmt = 	Min(v.OrigDocAmt), 
PerPost = 	Min(v.PerPost),
PerClosed = 	Min(v.PerClosed), 
Rlsed = 	Min(v.Rlsed), 
terms = 	Min(v.terms),
docbal = 	Min(v.docbal), 
AvgDayToPay = 	Min(v.AvgDayToPay), 
BillAttn = 	Min(v.BillAttn), 
BillPhone = 	Min(v.BillPhone),
cCuryId = 	Min(v.cCuryid),
CName = 	Min(v.CName),
StmtCycleId = 	Min(v.StmtCycleId), 
AgeDays00 = 	Min(v.AgeDays00),
AgeDays01 = 	Min(v.AgeDays01),
AgeDays02 = 	Min(v.AgeDays02), 
gAdjAmt = 	Sum(Case When v.gPerAppl <= r.BegPerNbr then v.gAdjAmt else 0 end), 
jAdjAmt = 	Sum(Case When v.jPerAppl <= r.BegPerNbr then v.jAdjAmt else 0 end),
gCuryAdjdAmt = 	Sum(Case When v.gPerAppl <= r.BegPerNbr then v.gAdjAmt else 0 end), 
jCuryAdjdAmt = 	Sum(Case When v.jPerAppl <= r.BegPerNbr then v.jAdjAmt else 0 end),
gAdjgDocDate = 	Min(v.gAdjgDocDate),
gAdjgPerPost = 	Min(v.gAdjgPerPost), 
CuryAdjgAmt = 	Sum(v.CuryAdjgAmt), 
gPerAppl = 	Min(v.gPerAppl),
jPerAppl = 	Min(v.jPerAppl),
jAdjgDocDate = Min(v.jAdjgDocDate), 
jAdjgPerPost = Min(v.jAdjgPerPost), 
CuryAdjdAmt = Sum(v.CuryAdjdAmt),
Descr = Min(v.Descr)

From vr_08610SelectAdjs v, rptruntime r 
where (((v.gAdjgPerPost <= r.BegPerNbr and v.gAdjgPerPost is not null and (v.PerClosed > r.EndPerNbr or v.PerClosed = ' ')) or 
	(v.jAdjgPerPost <= r.BegPerNbr and v.jAdjgPerPost is not null and (v.PerClosed > r.BegPerNbr or v.PerClosed = ' '))) or v.PerPost <= r.begPerNbr and
        (v.PerClosed > r.EndPerNbr or v.PerClosed = ' '))
       And r.reportnbr = '08611'

group by v.cpnyid, v.custid, v.doctype, v.refnbr, r.BegPerNbr


 
