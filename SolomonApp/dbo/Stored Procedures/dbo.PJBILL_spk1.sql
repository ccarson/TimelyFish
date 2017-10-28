 create procedure PJBILL_spk1 @parm1 varchar (16) , @parm2 varchar (4)  as
select * from PJBILL, PJPTDROL, PJINVSEC
where pjbill.project = pjptdrol.project and
pjptdrol.acct  = pjinvsec.acct    and
pjbill.project_billwith = @parm1  and
pjinvsec.inv_format_cd  = @parm2
order by pjptdrol.project,
pjptdrol.acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_spk1] TO [MSDSL]
    AS [dbo];

