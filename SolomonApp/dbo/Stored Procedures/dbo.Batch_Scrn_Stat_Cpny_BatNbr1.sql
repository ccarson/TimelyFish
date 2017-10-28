 Create Proc Batch_Scrn_Stat_Cpny_BatNbr1 @parm1 varchar ( 10), @parm2 varchar ( 5), @parm3 varchar ( 1), @parm4 varchar ( 10) as
       Select * from Batch
           where cpnyid = @parm1
                 and EditScrnNbr    =  @parm2
             and Status         =  @parm3
             and BatNbr      LIKE  @parm4
           order by CpnyId, EditScrnNbr, BatNbr


