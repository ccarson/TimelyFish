CREATE PROC cfpAbraDepTotalByChkDate 
	@BatNbr varchar(10) 
	AS
	SELECT chkdate, sum(depamount) As Amount 
	FROM
	OPENQUERY(ABRADATA,'Select * from PRCKHIST')
	WHERE RTrim(CashProj) = @BatNbr
	GROUP BY ChkDate
	HAVING Sum(DepAmount) <> 0
	ORDER BY ChkDate
