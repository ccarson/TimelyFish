 Create procedure ARTran_set_PerPost @parm1 varchar (10), @parm2 varchar (6), @parm3 varchar (10)
AS
UPDATE ARTran SET ARTran.PerPost = @parm2
WHERE ARTran.BatNbr = @parm1 and ARTran.PerPost <> @parm2 and ARTran.Refnbr <> @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARTran_set_PerPost] TO [MSDSL]
    AS [dbo];

