Create view dbo.vCFPigGroupTransBeforeStocking
as 

select pt.acct, pt.piggroupid, pt.qty, pt.trandate
from cftpginvtran pt
join cftpiggroup pg on (pt.piggroupid = pg.piggroupid)
where pg.pgstatusid in ('f', 'a', 't') and pt.inveffect = -1 and 

pt.trandate < (select min(trandate) from cftpginvtran where piggroupid = pt.piggroupid and 
inveffect > 0) and reversal = 0 
