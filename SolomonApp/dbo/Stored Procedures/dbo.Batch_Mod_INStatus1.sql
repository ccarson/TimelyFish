 /****** Object:  Stored Procedure dbo.Batch_Mod_INStatus1    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_Mod_INStatus1 @parm1 varchar ( 2) as
       Select * from Batch
           Where Module   =   @parm1
             and Status   IN ('B', 'S', 'I')
           order by Module, BatNbr


