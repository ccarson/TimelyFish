 create procedure PJBILL_spk2 @parm1 varchar (16) , @parm2 varchar (4)  as
select * from PJBILL, PJPTDSUM, PJINVSEC, PJPROJ
where pjbill.project = PJPTDSUM.project and
PJPTDSUM.project  = pjproj.project    and
PJPTDSUM.acct  = pjinvsec.acct    and
pjbill.project_billwith = @parm1  and
pjinvsec.inv_format_cd  = @parm2
order by PJPTDSUM.project,
PJPTDSUM.pjt_entity,
PJPTDSUM.acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_spk2] TO [MSDSL]
    AS [dbo];

