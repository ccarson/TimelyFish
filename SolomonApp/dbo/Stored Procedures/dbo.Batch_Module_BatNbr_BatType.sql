 /****** Object:  Stored Procedure dbo.Batch_Module_BatNbr_BatType    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc Batch_Module_BatNbr_BatType @parm1 varchar ( 2), @parm2 varchar ( 10) as
       Select * from Batch
           where Module  = @parm1
             and BatNbr  = @parm2
            And BatType <> 'C'



