 create procedure WS_SOSCHED_SMAXSCHEDREF  @parm1 varchar (15), @parm2 varchar(10), @parm3 varchar(5)   as  
select max(SchedRef) from SOSched where OrdNbr = @parm1 and CpnyID = @parm2 and LineRef = @parm3

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_SOSCHED_SMAXSCHEDREF] TO [MSDSL]
    AS [dbo];

