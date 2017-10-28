 create procedure PJEMPPJT_SPK4  @parm1 varchar (10) , @parm2 varchar (16)   as
select * from PJEMPPJT
where
employee  = @parm1 and
project like @parm2
order by employee, project, effect_date desc


