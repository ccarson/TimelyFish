 CREATE PROC p08990UpdARHistBegBal @parm1 VARCHAR (4) , @parm2 VARCHAR (4), @Parm3 VARCHAR (2)
AS

--INSERT ARHIST WHERE THERE IS NO ACTIVITY YET FOR THIS FISCYR, BUT IT SHOULD HAVE A BEGBAL
INSERT ARHist (AccruedRevBegBal, BegBal, CpnyID, CuryID, Crtd_DateTime, Crtd_Prog, Crtd_User, CustId, FiscYr, LUpd_DateTime,
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
SELECT DISTINCT 0, 0, v.CpnyID, @parm2, GETDATE(), '', '', v.CustID, @parm1, GETDATE(), '', '',
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @parm1 + @parm3,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, '', '', 0, 0,
       '', '', '', '', 0, 0, '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0
  FROM vi_08990ARHist_YtdInfo v LEFT OUTER JOIN arhist h
                                  ON h.cpnyid = v.cpnyid AND
                                     h.custid = v.custid AND
                                     h.fiscyr = @parm1
 WHERE h.custid IS NULL AND v.fiscyr = (@parm1 - 1)

--UPDATING THE ARHIST BEGBAL BY CYCLING THROUGH THE FISCYR'S FROM ARHIST.
UPDATE h
   SET  h.AccruedRevBegBal = ISNULL(v.AccruedRevBegBal-v.YTDAccruedRev, 0),
   	h.begbal = ISNULL((v.begbal + v.ytdsales + v.Ytddrmemo + v.YtdFinChrg + v.ytdrcpt +
                          v.YtdCrMemo + v.YtdDisc),0)
  FROM arhist h, vi_08990ARHist_YtdInfo v
 WHERE h.cpnyid = v.cpnyid AND h.custid = v.custid AND h.fiscyr = @parm1 AND
       v.fiscyr = (Select top 1 Fiscyr
                     FROM ARHIST H2
                    WHERE H2.cpnyid = h.Cpnyid
                      AND H2.CustId = h.CustId
                      AND H2.FiscYr < h.FiscYr
                    ORDER BY FiscYr DESC)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990UpdARHistBegBal] TO [MSDSL]
    AS [dbo];

