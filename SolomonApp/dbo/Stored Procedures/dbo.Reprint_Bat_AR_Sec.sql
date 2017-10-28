 Create Proc Reprint_Bat_AR_Sec @parm1 varchar(47), @parm2 varchar(7), @parm3 varchar(1)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
       Select * from Batch
           where Module  = "AR"
             and Rlsed =  1
             and cpnyid in

(select Cpnyid
 from vs_share_usercpny
   where userid = @parm1
   and scrn = @parm2
   and seclevel >= @parm3)

           order by BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Reprint_Bat_AR_Sec] TO [MSDSL]
    AS [dbo];

