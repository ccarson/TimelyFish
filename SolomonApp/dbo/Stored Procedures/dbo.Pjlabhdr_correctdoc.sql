
CREATE PROCEDURE Pjlabhdr_correctdoc @parm1 VARCHAR (10)
AS
    SELECT le_key
    FROM   PJLABHDR
    WHERE  docnbr = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Pjlabhdr_correctdoc] TO [MSDSL]
    AS [dbo];

