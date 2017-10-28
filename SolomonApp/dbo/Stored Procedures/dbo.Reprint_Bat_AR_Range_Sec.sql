 Create Proc Reprint_Bat_AR_Range_Sec @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar(47), @parm4 varchar(7), @parm5 varchar(1)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
       Select * from Batch
           where Module  = "AR"
             and Rlsed =  1
             and BatNbr between @parm1 and @parm2
             and cpnyid in

(select Cpnyid
 from vs_share_usercpny
   where userid = @parm3
   and scrn = @parm4
   and seclevel >= @parm5)

           order by BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Reprint_Bat_AR_Range_Sec] TO [MSDSL]
    AS [dbo];

