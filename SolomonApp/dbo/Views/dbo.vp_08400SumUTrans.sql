 

create view vp_08400SumUTrans as

select t.batnbr, t.custid, t.costtype, t.siteid, 
adjamt = sum(t.taxamt02)+sum(t.taxamt03), 
adjdiscamt = sum(t.taxamt03), 
recordid = min(t.recordid),
discrecordid = max(case when t.taxamt01 <> 0 then t.recordid else 0 end), 
curyadjdamt = sum(t.taxamt00)+sum(t.taxamt01), 
curyadjddiscamt = sum(t.taxamt01), 
w.useraddress,
curytxblamt00 = min(t.curytxblamt00),
curytxblamt01 = min(t.curytxblamt01)
from artran t, wrkrelease w 
where w.batnbr = t.batnbr and t.drcr = 'U'
group by t.batnbr, t.custid, t.costtype, t.siteid, w.useraddress


 
