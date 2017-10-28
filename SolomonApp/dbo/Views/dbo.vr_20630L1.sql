 

create view vr_20630L1 as
select r.bankacct, r.banksub, r.cpnyid, trantype = t.entryid, t.perpost, r.glperiod, t.trandate ,r.recondate, b.status, t.rlsed, b.module, t.drcr, t.trandesc,b.batnbr,t.refnbr, tranamt = t.curytranamt 
from catran t 
inner join bankrec r on 
t.entryid<>'TR' and t.entryid<>'ZZ' and t.bankcpnyid = r.cpnyid and t.bankacct = r.bankacct and t.banksub = r.banksub or
t.entryid = 'TR' and t.cpnyid = r.cpnyid  and t.acct = r.bankacct and t.sub = r.banksub
inner join batch b on b.module = 'CA' and t.batnbr = b.batnbr and r.cpnyid = b.cpnyid

union all

select r.bankacct, r.banksub, r.cpnyid, t.doctype, b.perpost, r.glperiod, b.dateent, r.recondate, b.status, b.rlsed, b.module,' ', 'Deposit',b.batnbr,' ',b.curydepositamt
from batch b 
inner join (select t.batnbr, doctype = max(t.doctype) from ardoc t where t.doctype  in ('PA','NS', 'PP', 'CS') group by t.batnbr) t 
      on b.batnbr = t.batnbr    
inner join bankrec r on b.cpnyid = r.cpnyid and b.bankacct = r.bankacct and b.banksub = r.banksub
where b.module = 'AR' and b.BatType not in ('C', 'R') and b.Status <> 'V' 

union all

select r.bankacct, r.banksub, r.cpnyid, d.doctype, d.perpost, r.glperiod, d.docdate, r.recondate, b.status, d.rlsed, b.module,' ',v.name,b.batnbr,d.refnbr, d.curyorigdocamt
from apdoc d
inner join vendor v on d.vendid = v.vendid
inner join batch b on b.module = 'AP' and d.cpnyid = b.cpnyid and d.batnbr = b.batnbr
inner join bankrec r on d.cpnyid = r.cpnyid and d.acct = r.bankacct and d.sub = r.banksub
where d.doctype <> 'SC'

union all

select r.bankacct, r.banksub, r.cpnyid, d.doctype, d.perpost, r.glperiod, d.chkdate, r.recondate, b.status, d.rlsed, b.module,' ','Payroll Record',b.batnbr,d.chknbr, d.netamt
from prdoc d
inner join batch b on b.module = 'PR' and d.cpnyid = b.cpnyid and d.batnbr = b.batnbr
inner join bankrec r on d.cpnyid = r.cpnyid and d.acct = r.bankacct and d.sub = r.banksub, casetup s (nolock)
where s.prtempname = 0 

union all

select r.bankacct, r.banksub, r.cpnyid, d.doctype, d.perpost, r.glperiod, d.chkdate, r.recondate, b.status, d.rlsed, b.module,' ',e.name,b.batnbr,d.chknbr,d.netamt
from prdoc d
inner join employee e on d.empid = e.empid
inner join batch b on b.module = 'PR' and d.cpnyid = b.cpnyid and d.batnbr = b.batnbr
inner join bankrec r on d.cpnyid = r.cpnyid and d.acct = r.bankacct and d.sub = r.banksub, casetup s (nolock)
where s.prtempname = 1 

union all

select r.bankacct, r.banksub, r.cpnyid, t.jrnltype, t.perpost, r.glperiod, t.trandate, r.recondate, b.status, t.rlsed, b.module,
(CASE WHEN t.curycramt<>0 THEN 'C' WHEN t.curydramt<>0 THEN 'D' END),t.trandesc,b.batnbr,t.refnbr,(CASE WHEN t.curycramt<>0 THEN t.curycramt ELSE t.curydramt END)
from gltran t
inner join batch b on b.module = 'GL' and b.battype ='N' and t.cpnyid = b.cpnyid and t.module = b.module and t.batnbr = b.batnbr 
inner join bankrec r on t.cpnyid = r.cpnyid and t.acct = r.bankacct and t.sub = r.banksub


 
