 CREATE PROCEDURE p08990ARHist_updateCOGS AS

INSERT ARHist
      (AccruedRevBegBal, BegBal, CpnyID, CuryID, Crtd_DateTime, Crtd_Prog, Crtd_User, CustId, FiscYr, LUpd_DateTime,
       LUpd_Prog, LUpd_User, NbrInvcPaid00, NbrInvcPaid01, NbrInvcPaid02, NbrInvcPaid03, NbrInvcPaid04,
       NbrInvcPaid05, NbrInvcPaid06, NbrInvcPaid07, NbrInvcPaid08, NbrInvcPaid09, NbrInvcPaid10,
       NbrInvcPaid11, NbrInvcPaid12, NoteId, PaidInvcDays00, PaidInvcDays01, PaidInvcDays02, PaidInvcDays03,
       PaidInvcDays04, PaidInvcDays05, PaidInvcDays06, PaidInvcDays07, PaidInvcDays08,
       PaidInvcDays09, PaidInvcDays10, PaidInvcDays11, PaidInvcDays12, PerNbr,
       PTDAccruedRev00, PTDAccruedRev01, PTDAccruedRev02, PTDAccruedRev03, PTDAccruedRev04, PTDAccruedRev05, PTDAccruedRev06,
       PTDAccruedRev07, PTDAccruedRev08, PTDAccruedRev09, PTDAccruedRev10, PTDAccruedRev11, PTDAccruedRev12,
       PTDCOGS00, PTDCOGS01, PTDCOGS02, PTDCOGS03, PTDCOGS04, PTDCOGS05, PTDCOGS06, PTDCOGS07, PTDCOGS08,
       PTDCOGS09, PTDCOGS10, PTDCOGS11, PTDCOGS12, PTDCrMemo00, PTDCrMemo01, PTDCrMemo02,
       PTDCrMemo03, PTDCrMemo04, PTDCrMemo05, PTDCrMemo06, PTDCrMemo07, PTDCrMemo08,
       PTDCrMemo09, PTDCrMemo10, PTDCrMemo11, PTDCrMemo12, PTDDisc00, PTDDisc01, PTDDisc02,
       PTDDisc03, PTDDisc04, PTDDisc05, PTDDisc06, PTDDisc07, PTDDisc08, PTDDisc09,
       PTDDisc10, PTDDisc11, PTDDisc12, PTDDrMemo00, PTDDrMemo01, PTDDrMemo02, PTDDrMemo03,
       PTDDrMemo04, PTDDrMemo05, PTDDrMemo06, PTDDrMemo07, PTDDrMemo08, PTDDrMemo09,
       PTDDrMemo10, PTDDrMemo11, PTDDrMemo12, PTDFinChrg00, PTDFinChrg01, PTDFinChrg02,
       PTDFinChrg03, PTDFinChrg04, PTDFinChrg05, PTDFinChrg06, PTDFinChrg07, PTDFinChrg08,
       PTDFinChrg09, PTDFinChrg10, PTDFinChrg11, PTDFinChrg12, PTDRcpt00, PTDRcpt01,
       PTDRcpt02, PTDRcpt03, PTDRcpt04, PTDRcpt05, PTDRcpt06, PTDRcpt07, PTDRcpt08, PTDRcpt09,
       PTDRcpt10, PTDRcpt11, PTDRcpt12, PTDSales00, PTDSales01, PTDSales02, PTDSales03,
       PTDSales04, PTDSales05, PTDSales06, PTDSales07, PTDSales08, PTDSales09, PTDSales10,
       PTDSales11, PTDSales12, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
       S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, User1, User2, User3, User4,
       User5, User6, User7, User8, YTDAccruedRev, YtdCOGS, YtdCrMemo, YtdDisc, YtdDrMemo, YtdFinChrg, YtdRcpt, YtdSales)
SELECT 0, 0, v.CpnyID, g.BaseCuryID, GETDATE(), '', '', v.CustID, v.FiscYr, GETDATE(),
       '', '', 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0,
       0, 0, 0, 0, CASE WHEN v.Fiscyr >= SUBSTRING(a.CurrPerNbr,1,4)
                        THEN a.CurrPerNbr
                        ELSE v.Fiscyr + CONVERT(CHAR(2),g.NbrPer)
                    END,
       0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0,
       0, 0, '', '', 0, 0, 0, 0,
       '', '', 0, 0, '', '', '', '', 0, 0,
       '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0
  FROM vi_08990sumCOGS v
       CROSS JOIN GLSetup g
       CROSS JOIN ARSetup a
       LEFT JOIN ARHist h ON h.CustID = v.CustID AND h.CpnyID = v.CpnyID AND h.FiscYr = v.FiscYr
  WHERE h.CustID IS NULL
  OPTION (FORCE ORDER)

UPDATE h
   SET PTDCOGS00 = v.PTDCOGS00, PTDCOGS01 = v.PTDCOGS01, PTDCOGS02 = v.PTDCOGS02, PTDCOGS03 = v.PTDCOGS03,
       PTDCOGS04 = v.PTDCOGS04, PTDCOGS05 = v.PTDCOGS05, PTDCOGS06 = v.PTDCOGS06,
       PTDCOGS07 = v.PTDCOGS07, PTDCOGS08 = v.PTDCOGS08, PTDCOGS09 = v.PTDCOGS09,
       PTDCOGS10 = v.PTDCOGS10, PTDCOGS11 = v.PTDCOGS11, PTDCOGS12 = v.PTDCOGS12,
       YTDCOGS = v.YTDCOGS
  FROM ARHist h JOIN vi_08990sumCOGS v
                  ON h.custid = v.custid AND
                     h.cpnyid = v.cpnyid AND
                     h.Fiscyr = v.fiscyr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990ARHist_updateCOGS] TO [MSDSL]
    AS [dbo];

