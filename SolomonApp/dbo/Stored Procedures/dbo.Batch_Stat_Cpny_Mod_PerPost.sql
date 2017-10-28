 /****** Object:  Stored Procedure dbo.Batch_Stat_Cpny_Mod_PerPost    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_Stat_Cpny_Mod_PerPost @parm1 varchar ( 1), @parm2 varchar ( 10), @parm3 varchar (2), @parm4 varchar (6) as
       Select * from Batch
           where Status   = @parm1
             and CpnyID like @parm2
             and Module like @parm3
             and PerPost <= @parm4
           order by Status, CpnyID, Module, BatNbr


