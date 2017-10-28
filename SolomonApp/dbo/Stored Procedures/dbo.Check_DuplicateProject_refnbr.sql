
 Create Proc Check_DuplicateProject_refnbr
	@RefNbr		Varchar(30),
	@BatNbr         VarChar (10)
   
AS

Select Count(*) from InPrjAllocation where SrcNbr = @RefNbr AND SrcType = 'IS' and OrdNbr <> @BatNbr Group by SrcNbr, SrcType


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Check_DuplicateProject_refnbr] TO [MSDSL]
    AS [dbo];

