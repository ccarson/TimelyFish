 /****** Object:  Stored Procedure dbo.Batch_PerEnt_Jrnl_Stat_BatNbr    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_PerEnt_Jrnl_Stat_BatNbr @parm1 varchar ( 6), @parm2 varchar ( 3), @parm3 varchar ( 1), @parm4 varchar ( 10) as
       Select * from Batch
           where PerEnt   =  @parm1
             and JrnlType =  @parm2
             and Status   =  @parm3
             and BatNbr   =  @parm4
       order by EditScrnNbr, BatNbr


