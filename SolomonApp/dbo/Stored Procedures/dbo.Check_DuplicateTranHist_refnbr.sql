
Create Proc Check_DuplicateTranHist_refnbr
	@RefNbr	    Varchar(30),
	@BatNbr     VarChar (10)
   
AS

    Select Count(*) from InPrjAllocTranHist where TranSrcNbr = @RefNbr and TranSrcType = 'ISS' Group by TranSrcNbr, TranSrcType


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Check_DuplicateTranHist_refnbr] TO [MSDSL]
    AS [dbo];

