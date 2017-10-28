 create procedure PJBILL_spinq @parm1 varchar (16)  as
select * from PJBILL, PJPROJ
where pjbill.project = pjproj.project and
pjbill.project Like @parm1 and
pjbill.project_billwith = pjbill.project
order by pjbill.project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_spinq] TO [MSDSL]
    AS [dbo];

