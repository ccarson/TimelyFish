 /****** Object:  Stored Procedure dbo.Reprint_Bat_AR_Range_Cpnyid    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Reprint_Bat_AR_Range_Cpnyid @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 10) as
       Select * from Batch
           where Module  = "AR"
             and Rlsed =  1
             and BatNbr between @parm1 and @parm2
             and cpnyid = @parm3
           order by BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Reprint_Bat_AR_Range_Cpnyid] TO [MSDSL]
    AS [dbo];

