
/****** Object:  Stored Procedure dbo.Batch_EditScrnNbr_Stat_BatNbr4    ******/
Create Proc Batch_EditScrnNbr_Stat_BatNbr4 @Parm1 varchar ( 10), @parm2 varchar ( 5), @parm3 varchar ( 1), @parm4 varchar ( 10) as
       Select * from Batch
           where CpnyID         =  @parm1
             and EditScrnNbr    =  @parm2
             and Status         =  @parm3
             and BatNbr      LIKE  @parm4
           order by CpnyID, EditScrnNbr, BatNbr 

