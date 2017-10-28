
CREATE PROCEDURE XDDWrkCheckSel_Delete
   @AccessNbr		smallint
AS

   DELETE 
   FROM 	XDDWrkCheckSel 
   WHERE	AccessNbr = @AccessNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDWrkCheckSel_Delete] TO [MSDSL]
    AS [dbo];

