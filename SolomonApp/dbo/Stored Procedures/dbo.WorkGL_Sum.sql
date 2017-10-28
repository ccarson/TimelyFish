 Create Procedure WorkGL_Sum
	@BatNbr		Varchar(10),
	@Module		Varchar(2)
As
	Select	BatNbr, Sum(CrAmt) As CrTot, Sum(DrAmt) As DrTot, Count(*) As RecCount
		From	Wrk10400_GLTran
		Where	BatNbr = @BatNbr
			And Module = @Module
		Group By BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WorkGL_Sum] TO [MSDSL]
    AS [dbo];

