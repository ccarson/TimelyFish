 create procedure PJBILL_SALL_PV  @parm1 varchar(100), @parm2 varchar (16)
  
  WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
  as
select * from PJBILL, PJPROJ
where pjbill.project = pjproj.project and
pjproj.CpnyId in
(select cpnyid from dbo.UserAccessCpny(@parm1))
   and
  pjbill.project like @parm2
order by pjbill.project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_SALL_PV] TO [MSDSL]
    AS [dbo];

