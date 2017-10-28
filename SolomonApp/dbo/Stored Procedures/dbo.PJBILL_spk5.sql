 create procedure PJBILL_spk5 @parm1 varchar (16) , @parm2 varchar (16)  as
select * from pjbill, pjproj
where
pjbill.project = pjproj.project and
pjbill.project_billwith = @parm1   and
pjbill.project like @parm2
order by pjbill.project


