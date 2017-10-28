 create procedure PJEMPPJT_SPK1  @parm1 varchar (10) , @parm2 varchar (16)   as
select * from PJEMPPJT
where    employee  = @parm1
and      project     =   @parm2
order by      employee,
project,
effect_date desc


