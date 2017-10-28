 Create Proc DDBatch_Module_DD_BatNbr @parm1 varchar ( 2), @parm2 varchar ( 10), @parm3 varchar ( 10)  as
    Select * from Batch
     where Module = @parm1
       and JrnlType = 'DD'
       and Status = 'U'
       and BatNbr LIKE @parm2
       and CpnyId LIKE @parm3
     order by Module, BatNbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DDBatch_Module_DD_BatNbr] TO [MSDSL]
    AS [dbo];

