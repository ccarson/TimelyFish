 CREATE PROCEDURE p08990Insert_ARHist @CurrPer varchar (6) AS

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
       0, 0, 0, 0, CASE WHEN v.Fiscyr >= SUBSTRING(@CurrPer,1,4)
                        THEN @CurrPer
                        ELSE v.Fiscyr + CONVERT(CHAR(2),g.NbrPer)
                    END,
       v.PTDAccruedRev00, v.PTDAccruedRev01, v.PTDAccruedRev02, v.PTDAccruedRev03, v.PTDAccruedRev04, v.PTDAccruedRev05, v.PTDAccruedRev06,
       v.PTDAccruedRev07, v.PTDAccruedRev08, v.PTDAccruedRev09, v.PTDAccruedRev10, v.PTDAccruedRev11, v.PTDAccruedRev12,
       0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0,
       v.PTDCrMemo00, v.PTDCrMemo01, v.PTDCrMemo02,
       v.PTDCrMemo03, v.PTDCrMemo04, v.PTDCrMemo05, v.PTDCrMemo06, v.PTDCrMemo07, v.PTDCrMemo08,
       v.PTDCrMemo09, v.PTDCrMemo10, v.PTDCrMemo11, v.PTDCrMemo12, v.PTDDisc00, v.PTDDisc01, v.PTDDisc02,
       v.PTDDisc03, v.PTDDisc04, v.PTDDisc05, v.PTDDisc06, v.PTDDisc07, v.PTDDisc08, v.PTDDisc09,
       v.PTDDisc10, v.PTDDisc11, v.PTDDisc12, v.PTDDrMemo00, v.PTDDrMemo01, v.PTDDrMemo02, v.PTDDrMemo03,
       v.PTDDrMemo04, v.PTDDrMemo05, v.PTDDrMemo06, v.PTDDrMemo07, v.PTDDrMemo08, v.PTDDrMemo09,
       v.PTDDrMemo10, v.PTDDrMemo11, v.PTDDrMemo12, v.PTDFinChrg00, v.PTDFinChrg01, v.PTDFinChrg02,
       v.PTDFinChrg03, v.PTDFinChrg04, v.PTDFinChrg05, v.PTDFinChrg06, v.PTDFinChrg07, v.PTDFinChrg08,
       v.PTDFinChrg09, v.PTDFinChrg10, v.PTDFinChrg11, v.PTDFinChrg12, v.PTDRcpt00, v.PTDRcpt01,
       v.PTDRcpt02, v.PTDRcpt03, v.PTDRcpt04, v.PTDRcpt05, v.PTDRcpt06, v.PTDRcpt07, v.PTDRcpt08, v.PTDRcpt09,
       v.PTDRcpt10, v.PTDRcpt11, v.PTDRcpt12, v.PTDSales00, v.PTDSales01, v.PTDSales02, v.PTDSales03,
       v.PTDSales04, v.PTDSales05, v.PTDSales06, v.PTDSales07, v.PTDSales08, v.PTDSales09, v.PTDSales10,
       PTDSales11, PTDSales12, '', '', 0, 0, 0, 0,
       '', '', 0, 0, '', '', '', '', 0, 0,
       '', '', '', '', v.YTDAccruedRev, 0, v.YtdCrMemo, v.YtdDisc, v.YtdDrMemo, v.YtdFinChrg, v.YtdRcpt, v.YtdSales
  FROM vi_08990HistUpd v CROSS JOIN glsetup g



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990Insert_ARHist] TO [MSDSL]
    AS [dbo];

