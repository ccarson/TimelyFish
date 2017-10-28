 create procedure PJEMPPJT_SPK0  @parm1 varchar (10) , @parm2 varchar (16) , @parm3beg smalldatetime , @parm3end smalldatetime   as
select * from PJEMPPJT
where    employee    = @parm1
and    project     LIKE @parm2
and    effect_date between  @parm3beg and @parm3end
order by employee,
project,
effect_date desc


