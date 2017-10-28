 create procedure PJUTGOAL_SPKFISCAL  @parm1 varchar (10) , @parm2 varchar (6) as
select * from PJUTGOAL, PJUTPER
where  PJUTGOAL.employee = @parm1
and    PJUTGOAL.fiscalno  LIKE @parm2
and PJUTGOAL.fiscalno = PJUTPER.period
order by PJUTGOAL.fiscalno


