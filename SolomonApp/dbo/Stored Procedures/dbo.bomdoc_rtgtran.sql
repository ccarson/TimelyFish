 Create Procedure bomdoc_rtgtran @RefNbr VarChar(10) As
     Select Top 1 * from rtgtran (NoLock)
         Where RefNbr = @RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[bomdoc_rtgtran] TO [MSDSL]
    AS [dbo];

