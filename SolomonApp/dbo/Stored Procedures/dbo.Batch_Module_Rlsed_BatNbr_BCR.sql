 /****** Object:  Stored Procedure dbo.Batch_Module_Rlsed_BatNbr_BCR    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_Module_Rlsed_BatNbr_BCR @parm1 varchar ( 2), @parm2 varchar ( 10) as
       Select * from Batch
           where Module  =    @parm1
             and Rlsed =  1
             and BatNbr  LIKE @parm2
                 and Status <> 'V'
           order by Module , Rlsed , BatNbr


