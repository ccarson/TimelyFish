 Create Proc VPBatch_Mod_INStatus_CpnyID @parm1 varchar ( 10) as
       Select * from Batch
           where Module   IN ('PR','VP')
             and CpnyId Like  @parm1
             and Status   IN ('B', 'S', 'I')
             and EditScrnNbr  = '58010'
           order by Module, BatNbr


