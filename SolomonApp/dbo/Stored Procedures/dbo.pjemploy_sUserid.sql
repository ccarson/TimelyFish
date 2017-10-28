 create procedure pjemploy_sUserid @parm1 varchar (50)  as
select *
from PJEMPLOY
where PJEMPLOY.user_id = @parm1


