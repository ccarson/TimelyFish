 create procedure PJBILL_SCURYPINQ_chk @parm1 varchar (16), @parm2 varchar(10)  as
select * from PJBILL, PJPROJ
where
pjbill.project = pjproj.project and
pjbill.project Like @parm1 and
pjbill.project_billwith = pjbill.project and
pjproj.status_pa = 'A'
and pjproj.cpnyID like @parm2
order by pjbill.project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_SCURYPINQ_chk] TO [MSDSL]
    AS [dbo];

