 

CREATE VIEW vi_08990SumPtdfields AS
SELECT Custid, Cpnyid, FiscYr, 
      YTDAccruedRev = (PTDAccruedRev00 + PTDAccruedRev01 + PTDAccruedRev02 + PTDAccruedRev03 + 
      			PTDAccruedRev04 + PTDAccruedRev05 + PTDAccruedRev06 + PTDAccruedRev07 + 
      			PTDAccruedRev08 + PTDAccruedRev09 + PTDAccruedRev10 + PTDAccruedRev11 + PTDAccruedRev12),
      YtdCrMemo = (PTDCrMemo00 + PTDCrMemo01 + PTDCrMemo02 + PTDCrMemo03 + PTDCrMemo04 +
                      PTDCrMemo05 + PTDCrMemo06 + PTDCrMemo07 + PTDCrMemo08 + PTDCrMemo09 +
                      PTDCrMemo10 + PTDCrMemo11 + PTDCrMemo12),
       YtdRcpt = (PTDRcpt00 + PTDRcpt01 + PTDRcpt02 + PTDRcpt03 + PTDRcpt04 + PTDRcpt05 +
                     PTDRcpt06 + PTDRcpt07 + PTDRcpt08 + PTDRcpt09 + PTDRcpt10 + PTDRcpt11 +
                     PTDRcpt12),
       YtdDisc = (PTDDisc00 + PTDDisc01 + PTDDisc02 + PTDDisc03 + PTDDisc04 + PTDDisc05 +
                     PTDDisc06 + PTDDisc07 + PTDDisc08 + PTDDisc09 + PTDDisc10 + PTDDisc11 +
                     PTDDisc12),
     YtdDrMemo = (PTDDrMemo00 + PTDDrMemo01 + PTDDrMemo02 + PTDDrMemo03 + PTDDrMemo04 +
                      PTDDrMemo05 + PTDDrMemo06 + PTDDrMemo07 + PTDDrMemo08 + PTDDrMemo09 +
                      PTDDrMemo10 + PTDDrMemo11 + PTDDrMemo12),
     YtdSales = (PTDSales00 + PTDSales01 + PTDSales02 + PTDSales03 + PTDSales04 +
                      PTDSales05 + PTDSales06 + PTDSales07 + PTDSales08 + PTDSales09 +
                      PTDSales10 + PTDSales11 + PTDSales12),
   YtdFinChrg = (PTDFinChrg00 + PTDFinChrg01 + PTDFinChrg02 + PTDFinChrg03 + PTDFinChrg04 +
                      PTDFinChrg05 + PTDFinChrg06 + PTDFinChrg07 + PTDFinChrg08 + PTDFinChrg09 +
                      PTDFinChrg10 + PTDFinChrg11 + PTDFinChrg12),
     YtdCOGS = (PTDCOGS00 + PTDCOGS01 + PTDCOGS02 + PTDCOGS03 + PTDCOGS04 +
                      PTDCOGS05 + PTDCOGS06 + PTDCOGS07 + PTDCOGS08 + PTDCOGS09 +
                      PTDCOGS10 + PTDCOGS11 + PTDCOGS12)
  FROM ARHist



 
