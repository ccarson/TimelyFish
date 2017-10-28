 CREATE PROCEDURE Updt_GLTran_Posted @PARM1 VARCHAR(2), @PARM2 VARCHAR (10), @PARM3 CHAR (1) AS
    UPDATE GLTran
    SET Posted = @parm3
    WHERE Module = @parm1 AND
    BatNbr = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Updt_GLTran_Posted] TO [MSDSL]
    AS [dbo];

