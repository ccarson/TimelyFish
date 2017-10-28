 Create Procedure PJLABHDR_SUNP @parm1 smalldatetime  as
select *
from pjlabhdr
	left outer join pjemploy
		on pjlabhdr.employee =  pjemploy.employee
	, pjlabdet, pj_account
where pjlabhdr.le_status in ('I', 'C', 'R', 'T') and
	pjlabhdr.le_type = 'R' and
	pjlabhdr.pe_date <= @parm1 and
	pjlabhdr.docnbr = pjlabdet.docnbr and
	pjlabdet.gl_acct = pj_account.gl_acct
order by pjlabhdr.docnbr


