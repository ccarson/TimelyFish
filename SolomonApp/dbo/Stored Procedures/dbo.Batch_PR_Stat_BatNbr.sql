 Create Proc Batch_PR_Stat_BatNbr @parm1 varchar ( 1), @parm2 varchar ( 10), @parm3 varchar ( 10) as
       Select * from Batch
           where ( EditScrnNbr  = '02635' or EditScrnNbr    = '02630' )
             and Status         =  @parm1
             and CpnyId         =  @parm2
             and BatNbr      LIKE  @parm3
           order by EditScrnNbr, BatNbr



