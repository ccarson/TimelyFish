 create proc load_PRBatch_Secured @parm1 varchar(47), @parm2 varchar(7), @parm3 varchar(1), @parm4 varchar(10)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

       Select * from Batch
           Where Batch.Module   =   'PR'
             and Batch.Status   IN ('B', 'S', 'I')
             and Batch.Editscrnnbr <> '58010'
             and cpnyid in

(select Cpnyid
  from vs_share_usercpny
 where userid = @parm1
   and scrn = @parm2
   and seclevel >= @parm3
   and cpnyid like @parm4 )

           order by Module, BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[load_PRBatch_Secured] TO [MSDSL]
    AS [dbo];

