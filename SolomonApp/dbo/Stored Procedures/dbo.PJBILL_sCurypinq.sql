 create procedure PJBILL_sCurypinq @parm1 varchar (16)  as
select * from PJBILL, PJPROJ
where
pjbill.project = pjproj.project and
pjbill.project Like @parm1 and
pjbill.project_billwith = pjbill.project and
pjproj.status_pa = 'A'
order by pjbill.project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_sCurypinq] TO [MSDSL]
    AS [dbo];

