
CREATE PROCEDURE XDDARDoc_DocClass_RefNbr
   @DocClass		varchar( 1 ),
   @RefNbr		varchar( 10 )

AS

   SELECT * From ARDoc Where DocClass = @DocClass and refnbr like @RefNbr and CuryDocBal <> 0 order by refnbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDARDoc_DocClass_RefNbr] TO [MSDSL]
    AS [dbo];

