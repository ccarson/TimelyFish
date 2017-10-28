 CREATE PROCEDURE
	smContractRev_SalesAnalysis_1
                  @startdate AS SMALLDATETIME
                , @enddate AS SMALLDATETIME
                , @branchid AS VARCHAR (10)
                , @prior AS BIT
                , @ri_id AS SMALLINT
                , @rectype AS CHAR (1)
AS
	SET NOCOUNT ON
	INSERT INTO smWrkSalesAnalysis
		(RI_ID
		, InvoiceType
		, RecType
		, ServiceCallID
		, CurCost
		, CurNbrCalls
		, CurHours
		, ServiceContractID
		, PriorCost
		, PriorNbrCalls
		, PriorHours
		, PrintMonth
		, PrintYear
		, CurRevenue
		, PriorRevenue
		, CallType
		, CustClass)
	SELECT	@ri_id AS RI_ID
		, 'C' AS InvoiceType
		, @rectype AS RecType
		, '' AS ServiceCallID
		, 0.0 AS CurCost
		, 0 AS CurNbrCalls
		, 0.0 AS CurHours
		, smContract.ContractID AS ServiceContractID
		, 0.0 AS PriorCost
		, 0 AS PriorNbrCalls
		, 0.0 AS PriorHours
		, (SUBSTRING(CONVERT(CHAR (10), smContractRev.RevDate, 101), 1, 2)) AS PrintMonth   -- month part of smContractRev.RevDate
		, (SUBSTRING(CONVERT(CHAR (10), smContractRev.RevDate, 101), 7, 4)) AS PrintYear   -- year part of smContractRev.RevDate
		, (CASE	WHEN @prior = 0 THEN smContractRev.RevAmount    -- Zero is FALSE
			        ELSE 0.0
	                 END) AS CurRevenue
		, (CASE	WHEN @prior = 0 THEN 0.0    -- Zero is FALSE
			        ELSE smContractRev.RevAmount
	                 END) AS PriorRevenue
		, (CASE WHEN smAgreement.AgreementTypeID IS NULL THEN '' ELSE smAgreement.DefaultCallType END) AS CallType
		, (CASE WHEN Customer.CustID IS NULL THEN '' ELSE Customer.ClassID END) AS CustClass
	FROM	smContract
		LEFT OUTER JOIN Customer
			ON smContract.CustID = Customer.CustID
		LEFT OUTER JOIN smAgreement
			ON smContract.ContractType = smAgreement.AgreementTypeID
		INNER JOIN smContractRev
			ON smContract.ContractID = smContractRev.ContractID
			AND smContractRev.RevDate BETWEEN @startdate AND @enddate
			AND smContractRev.Status = 'P'
	WHERE smContract.BranchID LIKE @branchid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContractRev_SalesAnalysis_1] TO [MSDSL]
    AS [dbo];

