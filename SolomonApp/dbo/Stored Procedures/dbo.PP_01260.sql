 Create Procedure PP_01260 @Company Varchar ( 10)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	Set NOCOUNT ON
	Begin Tran
	Delete from VW_AcctXRef where cpnyid = @Company
	Insert into VW_AcctXRef (Acct, AcctType, Active, CpnyId , Descr, User1, User2, User3, User4)
        	 Select Acct, AcctType, Active, @company, Descr, User1, User2, User3, User4 from Account
	Commit



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PP_01260] TO [MSDSL]
    AS [dbo];

