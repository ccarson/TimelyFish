 create procedure WS_SOLINE_SMAXLINEREF  @parm1 varchar (15), @parm2 varchar(10)   as  
select max(lineref) from SOLine where OrdNbr = @parm1 and CpnyID = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_SOLINE_SMAXLINEREF] TO [MSDSL]
    AS [dbo];

