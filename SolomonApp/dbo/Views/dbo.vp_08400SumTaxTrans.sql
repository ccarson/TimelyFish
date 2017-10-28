 

Create view vp_08400SumTaxTrans as

select w.useraddress, t.batnbr, t.custid, t.trantype, t.refnbr, 
curytaxamt = Case when x.prctaxincl = 'Y' then 0 else t.curytaxamt00 end,
taxamt = Case when x.prctaxincl = 'Y' then 0 else t.taxamt00 end, 
t.recordid
from wrkrelease w, artran t
left outer join salestax x on t.taxid00 = x.taxid
where w.batnbr = t.batnbr and w.module = 'AR' and ((t.drcr = 'C' and t.trantype IN ('DM', 'IN', 'CS')) or 
(t.drcr = 'D' and t.trantype = 'CM'))

union all

select w.useraddress, t.batnbr, t.custid, t.trantype, t.refnbr, 
curytaxamt = Case when x.prctaxincl = 'Y' then 0 else t.curytaxamt01 end,
taxamt = Case when x.prctaxincl = 'Y' then 0 else t.taxamt01 end,
t.recordid
from wrkrelease w, artran t
left outer join salestax x on t.taxid01 = x.taxid
where w.batnbr = t.batnbr and w.module = 'AR' and ((t.drcr = 'C' and t.trantype IN ('DM', 'IN', 'CS')) or 
(t.drcr = 'D' and t.trantype = 'CM'))

union all

select w.useraddress, t.batnbr, t.custid, t.trantype, t.refnbr, 
curytaxamt = Case when x.prctaxincl = 'Y' then 0 else t.curytaxamt02 end,
taxamt = Case when x.prctaxincl = 'Y' then 0 else t.taxamt02 end,
t.recordid
from wrkrelease w, artran t
left outer join salestax x on t.taxid02 = x.taxid
where w.batnbr = t.batnbr and w.module = 'AR' and ((t.drcr = 'C' and t.trantype IN ('DM', 'IN', 'CS')) or 
(t.drcr = 'D' and t.trantype = 'CM'))

union all

select w.useraddress, t.batnbr, t.custid, t.trantype, t.refnbr, 
curytaxamt = Case when x.prctaxincl = 'Y' then 0 else t.curytaxamt03 end,
taxamt = Case when x.prctaxincl = 'Y' then 0 else t.taxamt03 end,
t.recordid
from wrkrelease w, artran t
left outer join salestax x on t.taxid03 = x.taxid
where w.batnbr = t.batnbr and w.module = 'AR' and ((t.drcr = 'C' and t.trantype IN ('DM', 'IN', 'CS')) or 
(t.drcr = 'D' and t.trantype = 'CM'))


 
