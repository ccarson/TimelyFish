 create procedure PJBILL_spk4 @parm1 varchar (16)  as
select * from PJBILL, PJPROJ
where pjbill.project = pjproj.project and
pjbill.project Like @parm1 and
pjbill.project_billWith = pjbill.project and
pjproj.status_pa = 'A'
order by pjbill.project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_spk4] TO [MSDSL]
    AS [dbo];

