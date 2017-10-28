 create procedure  PJBILL_SALL_cpny @parm1 varchar (16)  as
select * from PJBILL, PJPROJ
where 
pjbill.project = pjproj.project and
pjbill.project like @parm1
order by pjbill.project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_SALL_cpny] TO [MSDSL]
    AS [dbo];

