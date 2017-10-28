 create procedure PJEMPPJT_SPK3  @parm1 varchar (10) as
select * from PJEMPPJT
where    employee    = @parm1
and    project = 'na'
order by employee,
project,
effect_date


