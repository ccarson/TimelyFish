
CREATE PROCEDURE GetBaseDecimalPrec
AS

 SELECT g.BaseCuryId, c.DecPl
   FROM GLSetup g WITH(NOLOCK), Currncy c WITH(NOLOCK)
  WHERE g.BaseCuryId = c.CuryId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetBaseDecimalPrec] TO [MSDSL]
    AS [dbo];

