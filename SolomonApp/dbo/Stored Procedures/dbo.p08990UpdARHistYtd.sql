 CREATE procedure p08990UpdARHistYtd AS

UPDATE h SET YTDAccruedRev = v.YTDAccruedRev, YtdCrMemo = v.YtdCrMemo, h.YtdRcpt = v.YtdRcpt, h.YtdDisc = v.YtdDisc,
             YtdDrMemo = v.YtdDrMemo,YtdSales = v.YtdSales, YtdFinChrg = v.YtdFinChrg,
             YtdCOGS = v.YtdCOGS
    FROM ARHist h, vi_08990SumPtdFields v
   WHERE h.custid = v.custid AND h.cpnyid = v.cpnyid AND h.FiscYr = v.FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990UpdARHistYtd] TO [MSDSL]
    AS [dbo];

