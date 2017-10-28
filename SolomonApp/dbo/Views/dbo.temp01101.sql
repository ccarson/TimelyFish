create view temp01101
as
select batnbr, tranamt, qty, trandate, unitcost = Round(CASE unitdesc WHEN 'TON' THEN tranamt/(qty*2000) ELSE tranamt/qty END,4), unitdesc
	from intran
	where invtid = '01101' and TranType = 'RC'
	and siteid = '102'

