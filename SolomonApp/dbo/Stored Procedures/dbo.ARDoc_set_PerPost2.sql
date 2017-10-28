 Create procedure ARDoc_set_PerPost2 @parm1 varchar (10), @parm2 varchar (6)
AS
UPDATE ARDOC SET ARDoc.PerPost = @parm2
WHERE ARDoc.BatNbr = @parm1 and ARDoc.PerPost <> @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_set_PerPost2] TO [MSDSL]
    AS [dbo];

