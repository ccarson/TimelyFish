 Create Proc Delete_TrnsfrDoc
    @parm1 varchar ( 10)
as
Delete from TrnsfrDoc
    Where BatNbr Not In
      (Select Batnbr from batch
	  Where Module = 'IN'
            And Cpnyid = @Parm1)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_TrnsfrDoc] TO [MSDSL]
    AS [dbo];

