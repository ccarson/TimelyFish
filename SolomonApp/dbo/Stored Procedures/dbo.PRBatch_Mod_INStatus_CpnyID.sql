 Create Proc PRBatch_Mod_INStatus_CpnyID @parm1 varchar ( 2), @parm2 varchar ( 10) as
       Select * from Batch
           where Module   =   @parm1
             and CpnyId Like  @parm2
             and Status   IN ('B', 'S', 'I')
             and EditScrnNbr  <> '58010'
           order by Module, BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRBatch_Mod_INStatus_CpnyID] TO [MSDSL]
    AS [dbo];

