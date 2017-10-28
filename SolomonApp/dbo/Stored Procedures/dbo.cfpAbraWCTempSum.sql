CREATE PROC cfpAbraWCTempSum
	@BatNbr varchar(10)
	AS
	Select Round(Sum(Amount),2) As Amount,
		ChkDate, Company, OrgLevel1, OrgLevel2, OrgLevel3 
	FROM AbraWCTemp
	WHERE BatNbr = @BatNbr
	GROUP BY Company, OrgLevel1, OrgLevel2, OrgLevel3, ChkDate
	ORDER BY Company, OrgLevel1, OrgLevel2, OrgLevel3, ChkDate
