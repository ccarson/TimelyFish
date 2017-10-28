 create procedure pjproj_spk2em @parm1 varchar (10), @parm2 varchar (16)  as
select * from PJPROJ, pjprojem
where pjproj.project = pjprojem.project and
(pjprojem.employee = @parm1 or pjprojem.employee = '*') and
pjproj.project like @parm2 and
pjproj.status_pa = 'A' and
pjproj.status_lb = 'A'
order by pjproj.project

