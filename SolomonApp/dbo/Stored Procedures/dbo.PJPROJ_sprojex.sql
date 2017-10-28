 create procedure PJPROJ_sprojex @parm1 varchar (16)  as
select *
from PJPROJ
	left outer join PJPROJEX
		on PJPROJ.project = PJPROJEX.project
where PJPROJ.project = @parm1
order by pjproj.project

