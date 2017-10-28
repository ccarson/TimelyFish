 /****** Object:  Stored Procedure dbo.Batch_Mod_OrigBNbr_Stat_Jrnl_    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_Mod_OrigBNbr_Stat_Jrnl_ @parm1 varchar ( 2), @parm2 varchar ( 10), @parm3 varchar ( 3), @parm4 varchar ( 6) as
       Select * from Batch
           where Module     =  @parm1
             and OrigBatNbr =  @parm2
             and Status     IN ('U', 'P')
             and JrnlType   =  @parm3
             and PerPost    =  @parm4
           order by Module, OrigBatNbr, Status


