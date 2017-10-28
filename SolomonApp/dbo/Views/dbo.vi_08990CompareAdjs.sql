 

CREATE VIEW vi_08990CompareAdjs as

SELECT v.custid, v.doctype, v.refnbr, v.origdocamt, v.docbal,
       SumOfAllAdjs = v.rgolamt + v.adjamt + v.adjdiscamt,
       DocBalPlusAdjs = v.rgolamt + v.adjamt + v.adjdiscamt + v.docbal,
       v.curyorigdocamt,v.curydocbal,
       CurySumOfAllAdjs = v.curyadjamt + v.curyadjdiscamt, 
       CuryDocBalPlusAdjs = v.curyadjamt + v.curyadjdiscamt + v.curydocbal

  FROM vi_08990SumAdjs v



 
