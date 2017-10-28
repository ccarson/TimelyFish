 Create procedure ARTran_set_PerPost2 @parm1 varchar (10), @parm2 varchar (6)
AS
UPDATE ARTran SET ARTran.PerPost = @parm2
WHERE ARTran.BatNbr = @parm1 and ARTran.PerPost <> @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARTran_set_PerPost2] TO [MSDSL]
    AS [dbo];

