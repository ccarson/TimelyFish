 create procedure pjproj_spk1em @parm1 varchar (10), @parm2 varchar (16)  as
select * from PJPROJ, pjprojem
where pjproj.project = pjprojem.project and
(pjprojem.employee = @parm1 or pjprojem.employee = '*') and
pjproj.project like @parm2 and
pjproj.status_pa = 'A'
order by pjproj.project

