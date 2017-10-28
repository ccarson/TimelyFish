
CREATE PROCEDURE Pjlabhdr_le_id06 @parm1 VARCHAR (10)
AS
    SELECT le_id06
    FROM   PJLABHDR
    WHERE  docnbr = @parm1
    ORDER  BY docnbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Pjlabhdr_le_id06] TO [MSDSL]
    AS [dbo];

