 Create Proc Batch_Mod_Rlsed @parm1 varchar ( 10), @parm2 varchar ( 2) as
       Select * from Batch with (nolock)
           where BatNbr  = @parm1
             and Module = @parm2
                 and Rlsed = 1



