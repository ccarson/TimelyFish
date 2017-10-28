 Create Proc Delete_AssyDoc
    @parm1 varchar ( 10)
as
Delete from AssyDoc
    Where BatNbr Not In
      (Select Batnbr from batch
	  Where Module = 'IN'
            And Cpnyid = @Parm1)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_AssyDoc] TO [MSDSL]
    AS [dbo];

