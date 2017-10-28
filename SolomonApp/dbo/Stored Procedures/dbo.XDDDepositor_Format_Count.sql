
CREATE PROCEDURE XDDDepositor_Format_Count
   @FormatID		varchar( 15 )

AS

   -- count if in XDDDepositor
   SELECT 	count(*) 
   FROM 	XDDDepositor D (nolock)
   WHERE	D.FormatID = @FormatID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_Format_Count] TO [MSDSL]
    AS [dbo];

