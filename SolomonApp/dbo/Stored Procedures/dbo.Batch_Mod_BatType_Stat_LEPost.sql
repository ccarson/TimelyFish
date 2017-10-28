 /****** Object:  Stored Procedure dbo.Batch_Mod_BatType_Stat_LEPost    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_Mod_BatType_Stat_LEPost @parm1 varchar ( 2), @parm2 varchar ( 1), @parm3 varchar ( 1), @parm4 varchar ( 6) as
       Select * from Batch, Currncy
           where Batch.CuryId = Currncy.CuryId
             and Module  =    @parm1
             and BatType like @parm2
             and Batch.Status  =    @parm3
             and PerPost <=   @parm4
           order by Module, BatNbr, Batch.Status


