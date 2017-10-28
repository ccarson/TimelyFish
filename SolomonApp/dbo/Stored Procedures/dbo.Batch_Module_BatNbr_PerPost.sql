 Create Procedure Batch_Module_BatNbr_PerPost @parm1 varchar ( 2), @parm2 varchar ( 10), @parm3 varchar (6) as
       Select * from Batch
           where Module  = @parm1
             and BatNbr  = @parm2
             and PerPost = @parm3


