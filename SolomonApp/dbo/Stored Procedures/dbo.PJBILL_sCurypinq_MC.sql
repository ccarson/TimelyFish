 create procedure [dbo].[PJBILL_sCurypinq_MC] @parm1 varchar (10), @parm2 varchar(100), @parm3 varchar (16)
 WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
 as
select * from PJBILL, PJPROJ
where
pjbill.project = pjproj.project and
pjbill.project_billwith = pjbill.project and
pjproj.status_pa = 'A' and	
pjproj.cpnyID Like @parm1 and
pjproj.CpnyId in	(select cpnyid from dbo.UserAccessCpny(@parm2))   and
pjbill.project Like @parm3
order by pjbill.project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_sCurypinq_MC] TO [MSDSL]
    AS [dbo];

