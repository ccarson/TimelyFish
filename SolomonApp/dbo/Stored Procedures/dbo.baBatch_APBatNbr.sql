Create Procedure baBatch_APBatNbr @parm1 varchar (10)  as 
    Select * from Batch Where Module = 'AP' and BatNbr = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[baBatch_APBatNbr] TO [MSDSL]
    AS [dbo];

