 create procedure PJBILL_spk7 @parm1 varchar (16)  as
select b.*, p.*, x.*
from PJBILL b
	left outer join PJPROJEX x
		on b.project = x.project
	,PJPROJ p
where b.project = p.project and
b.project Like @parm1 and
p.status_pa = 'A'
order by b.project


