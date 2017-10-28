 create procedure PJBILL_SPINQ_MC @parm1 varchar (100), @parm2 varchar (16)  as
select * from PJBILL, PJPROJ
where pjbill.project = pjproj.project and
pjproj.CpnyId in
(select cpnyid from dbo.UserAccessCpny(@parm1)) and
pjbill.project Like @parm2 and
pjbill.project_billwith = pjbill.project
order by pjbill.project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_SPINQ_MC] TO [MSDSL]
    AS [dbo];

