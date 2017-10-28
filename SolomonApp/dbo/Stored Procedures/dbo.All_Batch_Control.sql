 Create Proc All_Batch_Control @parm1 varchar (2), @parm2 varchar (10) as
       Select * from Batch
           where Module  = @parm1
             And CpnyId LIKE @parm2
             And Rlsed = 1
             And ((Status IN ('P','U', 'C') and Module <> 'PO') or (Status = 'C' and Module = 'PO'))
           order by BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[All_Batch_Control] TO [MSDSL]
    AS [dbo];

