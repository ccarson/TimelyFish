 create procedure PJBILL_spk4co @parm1 varchar (10), @parm2 varchar (16)  as
select * from PJBILL, PJPROJ
where pjbill.project = pjproj.project and
pjbill.project Like @parm2 and
pjbill.project_billWith = pjbill.project and
pjproj.status_pa = 'A' and
pjproj.cpnyid = @parm1
order by pjbill.project


