 create procedure PJBILL_sCheckBW @parm1 varchar (16)  as
select PJBILL.* from PJBILL, PJPROJ
where
pjbill.project_billwith = @parm1 and
pjbill.project_billwith <> pjbill.project and
pjbill.project = pjproj.project and
pjproj.status_pa <> 'D'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_sCheckBW] TO [MSDSL]
    AS [dbo];

