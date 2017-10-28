 /****** Object:  Stored Procedure dbo.Batch_Module_Rlsed_BCR1    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_Module_Rlsed_BCR1 @parm1 varchar ( 2), @parm2 varchar ( 10), @parm3 varchar ( 10) as
       Select * from Batch
           where Module  =    @parm1
             and Rlsed =  1
             and BatNbr between @parm2 and @parm3
           order by Module, Rlsed, BatNbr


