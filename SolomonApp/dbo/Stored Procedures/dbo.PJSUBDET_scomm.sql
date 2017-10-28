 create procedure PJSUBDET_scomm as
select * from PJSUBDET, PJSUBCON, PJ_ACCOUNT
where  	 pjsubdet.project = pjsubcon.project
and pjsubdet.subcontract = pjsubcon.subcontract
and pjsubcon.status_sub = 'A'
and pjsubdet.gl_acct = pj_account.gl_acct
order by pjsubdet.project, pjsubdet.subcontract, pjsubdet.sub_line_item



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBDET_scomm] TO [MSDSL]
    AS [dbo];

