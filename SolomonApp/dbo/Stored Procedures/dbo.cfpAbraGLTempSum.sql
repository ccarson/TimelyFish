CREATE PROC cfpAbraGLTempSum
	@BatNbr varchar(10)
	AS

	Select AcctNumber, ChkDate, Company, Round(sum(Credit),2) As Credit, Sum(Debit) As Debit, 
		GLOrg1, GLOrg2, GLOrg3 
		FROM AbraGLTemp 
		WHERE Batnbr = @BatNbr
		GROUP BY Company, AcctNumber, GLOrg1, GLOrg2, GLOrg3, ChkDate 
		ORDER BY Company, AcctNumber, GLOrg1, GLOrg2, GLOrg3, ChkDate 

