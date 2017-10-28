 

Create View vi_08990CompHistToCalc as


Select 

h.custid, h.cpnyid, 

CalcCurBal = Round(h.PTDSales00 + h.PTDSales01 + h.PTDSales02 + h.PTDSales03 + h.PTDSales04 + h.PTDSales05 + h.PTDSales06 +
h.PTDSales07 + h.PTDSales08 + h.PTDSales09 + h.PTDSales10 + h.PTDSales11 + h.PTDSales12 + h.PTDDrMemo00 + h.PTDDrMemo01 +
h.PTDDrMemo02 + h.PTDDrMemo03 + h.PTDDrMemo04 + h.PTDDrMemo05 + h.PTDDrMemo06 + h.PTDDrMemo07 + h.PTDDrMemo08 + h.PTDDrMemo09 +
h.PTDDrMemo10 + h.PTDDrMemo11 + h.PTDDrMemo12 +  h.PTDFinChrg00 + h.PTDFinChrg01 + h.PTDFinChrg02 + h.PTDFinChrg03 + h.PTDFinChrg04 +
h.PTDFinChrg05 + h.PTDFinChrg06 + h.PTDFinChrg07 +  h.PTDFinChrg08 + h.PTDFinChrg09 + h.PTDFinChrg10 + h.PTDFinChrg11 + 
h.PTDFinChrg12 -

h.PTDRcpt00 - h.PTDRcpt01 - h.PTDRcpt02 - h.PTDRcpt03 - h.PTDRcpt04 - h.PTDRcpt05 - h.PTDRcpt06 - h.PTDRcpt07 - 
h.PTDRcpt08 -  h.PTDRcpt09 - h.PTDRcpt10 - h.PTDRcpt11 - h.PTDRcpt12 -  h.PTDDisc00 - h.PTDDisc01 - h.PTDDisc02 - h.PTDDisc03 -
h.PTDDisc04 - h.PTDDisc05 - h.PTDDisc06 - h.PTDDisc07 - h.PTDDisc08 - h.PTDDisc09 - h.PTDDisc10 - h.PTDDisc11 - h.PTDDisc12 -

h.PTDCrMemo00 - h.PTDCrMemo01 - h.PTDCrMemo02 - h.PTDCrMemo03 - h.PTDCrMemo04 - h.PTDCrMemo05 - h.PTDCrMemo06 - 
h.PTDCrMemo07 - h.PTDCrMemo08 - h.PTDCrMemo09 - h.PTDCrMemo10 - h.PTDCrMemo11 - h.PTDCrMemo12 + h.begbal, c.DecPl),

SumNewBals = Round(v.NewCurrentBal + v.NewFutureBal, c.DecPl), 
SumOldBals = Round(v.OldCurrentBal + v.OldFutureBal, c.DecPl)

from arhist h, vi_08990CompCustBal v, glsetup g, currncy c
where h.custid = v.custid and h.cpnyid = v.cpnyid and 
      h.fiscyr = (select max(fiscyr) 
                  from arhist h2 where h2.custid = h.custid AND h2.cpnyid = h.cpnyid)
      AND g.basecuryid = c.curyid



 
