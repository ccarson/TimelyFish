 create procedure PJUTGOAL_SEQUAL  @parm1 varchar (10) , @parm2 varchar (6) as
select * from PJUTGOAL
where  PJUTGOAL.employee = @parm1
and    PJUTGOAL.fiscalno  = @parm2


