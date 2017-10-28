 create procedure PJSUBDET_SALL @parm1 varchar (16) , @parm2 varchar (16) , @parm3 varchar (4) as
select *
from PJSUBDET
	left outer join PJ_Account
		on PJSUBDET.gl_Acct = Pj_Account.gl_Acct
where PJSUBDET.project = @parm1 and
	PJSUBDET.subcontract = @parm2 and
	PJSUBDET.sub_line_item LIKE @parm3
order by PJSUBDET.project, PJSUBDET.subcontract, PJSUBDET.sub_line_item



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBDET_SALL] TO [MSDSL]
    AS [dbo];

