 Create procedure ARDoc_set_PerPost3 @parm1 varchar (10), @parm2 varchar (6), @parm3 varchar (10), @parm4 varchar(15)
AS
UPDATE ARDOC SET ARDoc.PerPost = @parm2
WHERE ARDoc.BatNbr = @parm1 and ARDoc.PerPost <> @parm2 and (ARDoc.Refnbr <> @parm3 or ARDoc.CustID <> @parm4)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_set_PerPost3] TO [MSDSL]
    AS [dbo];

