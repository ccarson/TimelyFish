 CREATE PROCEDURE FOBPoint_All @parm1 VARCHAR(15)
AS
      SELECT * FROM FOBPoint
      WHERE FOBid LIKE @parm1
      ORDER BY FOBid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FOBPoint_All] TO [MSDSL]
    AS [dbo];

