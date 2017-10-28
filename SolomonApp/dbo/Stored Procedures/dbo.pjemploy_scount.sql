 create procedure pjemploy_scount @parm1 smalldatetime   as
select Count(*) from pjemploy
where   em_id08 = @parm1


