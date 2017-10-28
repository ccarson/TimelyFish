 

create view vi_08990ARHist_YtdInfo as
select h1.cpnyid, h1.custid, h1.fiscyr, h1.begbal,
       h1.AccruedRevBegBal,	
       h1.ytdsales, h1.Ytddrmemo, h1.YtdFinChrg,
       YtdRcpt = -1 * h1.ytdrcpt, YtdCrMemo = -1 * h1.YtdcrMemo,
       YtdDisc = -1 * h1.ytdDisc,
       YTDAccruedRev = -1 * h1.YTDAccruedRev
from arhist h1



 
