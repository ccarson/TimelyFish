 Create procedure ARDoc_set_PerPost @parm1 varchar (10), @parm2 varchar (6), @parm3 varchar (10)
AS
UPDATE ARDOC SET ARDoc.PerPost = @parm2
WHERE ARDoc.BatNbr = @parm1 and ARDoc.PerPost <> @parm2 and ARDoc.Refnbr <> @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_set_PerPost] TO [MSDSL]
    AS [dbo];

