 create procedure PJEMPPJT_SPK2  @parm1 varchar (10) , @parm2 varchar (16) , @parm3 smalldatetime   as
If @parm2 = '' or @parm2 = '  '
    begin
        Select @parm2 = 'na'
    end
select * from PJEMPPJT
where    employee  = @parm1
and      project     =   @parm2
and    effect_date <=  @parm3
order by      employee,
project,
effect_date desc


