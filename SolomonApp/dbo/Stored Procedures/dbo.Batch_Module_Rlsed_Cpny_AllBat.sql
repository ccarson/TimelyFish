 /****** Object:  Stored Procedure dbo.Batch_Module_Rlsed_Cpny_AllBat    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_Module_Rlsed_Cpny_AllBat @parm1 Varchar ( 2), @parm2 Varchar ( 10), @parm3 Varchar ( 10) as
        Select * from Batch
           where Module  = @parm1
             And CpnyId Like @parm2
                 and Rlsed = 1
             and BatNbr  LIKE @parm3
           order by Module, Rlsed, BatNbr DESC


