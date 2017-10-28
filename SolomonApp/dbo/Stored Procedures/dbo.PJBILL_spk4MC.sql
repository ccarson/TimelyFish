 create procedure PJBILL_spk4MC @parm1 Varchar(10), @parm2 varchar(100) , @parm3 varchar (16) 
  
  WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
  as
select * from PJBILL, PJPROJ
where pjbill.project = pjproj.project and
pjproj.cpnyID like @parm1 and
pjbill.project_billWith = pjbill.project and
pjproj.status_pa = 'A'
and pjproj.cpnyid in (select cpnyid from dbo.UserAccessCpny(@parm2))  
and
pjbill.project Like @parm3
order by pjbill.project


