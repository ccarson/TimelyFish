 CREATE PROCEDURE WOSOHeader_All
   @OrdNbr	varchar(15)
AS
   SELECT	*
   FROM		SOHeader
   WHERE	OrdNbr LIKE @OrdNbr and
                Status = 'O'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOSOHeader_All] TO [MSDSL]
    AS [dbo];

