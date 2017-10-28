 create procedure PJSUBDET_scomm2 as
select PJSUBDET.*, PJSUBCON.vendid, PJ_ACCOUNT.*, PJPROJ.*
from PJSUBDET, PJSUBCON, PJ_ACCOUNT, PJPROJ
where    pjsubdet.project = pjsubcon.project
and pjsubdet.subcontract = pjsubcon.subcontract
and pjsubcon.status_sub = 'A'
and pjsubdet.gl_acct = pj_account.gl_acct
and pjproj.project=pjsubcon.project
order by pjsubdet.project, pjsubdet.subcontract, pjsubdet.sub_line_item



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBDET_scomm2] TO [MSDSL]
    AS [dbo];

