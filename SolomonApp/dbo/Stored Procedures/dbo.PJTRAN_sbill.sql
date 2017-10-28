 create procedure PJTRAN_sbill @parm1 varchar (6) , @parm2 smalldatetime , @parm3 varchar (16) , @parm4 varchar (24) as
select pjtran.*,
	pjproj.project, pjproj.gl_subacct, pjproj.billcuryid,
	pjbill.project, pjbill.project_billwith, pjbill.bill_type_cd,
	pjrules.bill_type_cd, pjrules.acct, pjrules.li_type, pjacct.ca_id03, pjpent.fips_num,
	pjpent.pe_id35, pjpent.pe_id36,pjtranex.*
from pjtran
	left outer join pjtranex
		on 	PJTRAN.fiscalno = PJTRANEX.fiscalno
		and	PJTRAN.system_cd = PJTRANEX.system_cd
		and PJTRAN.batch_id = PJTRANEX.batch_id
		and PJTRAN.detail_num = PJTRANEX.detail_num
	, pjproj, pjbill, pjrules, pjacct, pjpent
where
	pjtran.fiscalno = @parm1 and
	pjtran.tr_status = ' ' and
	pjtran.project like @parm3 and
	pjtran.trans_date <= @parm2 and
	pjtran.project = pjproj.project and
	pjproj.gl_subacct like @parm4 and
	pjtran.project = pjbill.project and
	pjbill.bill_type_cd = pjrules.bill_type_cd and
	pjtran.acct = pjrules.acct and
	pjtran.acct = pjacct.acct and
	pjtran.project = pjpent.project and
	pjtran.pjt_entity = pjpent.pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTRAN_sbill] TO [MSDSL]
    AS [dbo];

