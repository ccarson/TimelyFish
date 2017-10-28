
CREATE PROCEDURE XDDAPDoc_Update_PmtMethod
   @BatNbr		varchar( 10 ),
   @DocClass		varchar( 1 ),
   @PmtMethodCode	varchar( 1 )
   
AS

   UPDATE	APDoc
   SET		PmtMethod = @PmtMethodCode
   WHERE	BatNbr = @BatNbr
   		and DocClass = @DocClass
		and DocType NOT IN ('MC', 'SC', 'VT')  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDAPDoc_Update_PmtMethod] TO [MSDSL]
    AS [dbo];

