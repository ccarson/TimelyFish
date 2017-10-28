 create procedure PJEMPLOY_sAssignAll @parm1 varchar (10) as
select *
From PJEMPLOY
Where PJEMPLOY.employee like @parm1


