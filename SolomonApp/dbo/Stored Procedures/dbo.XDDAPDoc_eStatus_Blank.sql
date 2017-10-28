
CREATE PROCEDURE XDDAPDoc_eStatus_Blank
   @Acct		varchar( 10 ),
   @SubAcct		varchar( 24 ),
   @DocType		varchar( 2 ),
   @RefNbr		varchar( 10 )
   
AS

   UPDATE		APDoc
   SET			eStatus = ''   
   WHERE		Acct = @Acct
   			and Sub = @SubAcct
   			and DocType = @DocType
   			and RefNbr = @RefNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDAPDoc_eStatus_Blank] TO [MSDSL]
    AS [dbo];

