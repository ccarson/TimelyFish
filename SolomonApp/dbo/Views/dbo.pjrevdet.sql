 

create view pjrevdet as
select	
      pjtran.tr_id26 Period,
	pjtran.trans_date 'Date',
	pjtran.project Project,
	pjtran.pjt_entity Task,
	pjtran.tr_id05 LaborClass,
	pjtran.employee Employee,
	pjtran.voucher_num DocNbr,
	pjtran.vendor_num Vendor,
	pjacct.id5_sw  AcctClass,
	'SrcID' = case when pjtranex.tr_id12 = '' then
			pjtranex.tr_id11
			else pjtranex.tr_id12
			end,
	'SrcAcct' = case when pjtranex.tr_id12 = '' then
			pjtran.acct
			else pjtran.data1
			end,
	'Hours' = case when pjacct.id5_sw = 'L' then 
			round(pjtran.units,2)
			else 0.00
			end,
	'Revenue' = case when pjacct.id5_sw = 'R' then 
			round(pjtran.amount,2)
			else 0.00
			end,
	'RevAdj' = case when pjacct.id5_sw = 'A' then 
			round(pjtran.amount,2)
			else 0.00
			end,
	'Labor' = case when pjacct.id5_sw in ('L','X') then 
			round(pjtran.amount,2)
			else 0.00
			end
from pjtran, pjtranex, pjacct
where	pjtran.fiscalno = pjtranex.fiscalno
   and  pjtran.tr_id26 <> ''
   and	pjtran.system_cd = pjtranex.system_cd
   and	pjtran.batch_id = pjtranex.batch_id
   and	pjtran.detail_num = pjtranex.detail_num
   and	pjacct.acct = pjtran.acct
   and  pjacct.id5_sw in ('R','A','L','X')

 
