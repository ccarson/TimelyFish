CREATE Proc XBankDefaultPrinter_All
		@CpnyID varchar(10),
		@Acct varchar(10),
		@SubAcct Varchar(24),
		@ComputerName varchar(25)
AS

Select * from XBDfltPrinter
Where
	CpnyID = @CpnyID and
	Acct = @Acct and
	Subacct = @SubAcct and
	ComputerName = @ComputerName
Order By
	CpnyID,
	Acct,
	SubAcct,
	ComputerName



GO
GRANT CONTROL
    ON OBJECT::[dbo].[XBankDefaultPrinter_All] TO [MSDSL]
    AS [dbo];

