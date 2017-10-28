 CREATE PROCEDURE
	smContractRev_Sales_Post_1
                  @startperiod AS VARCHAR (6)
                , @endperiod AS VARCHAR (6)
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
		, (SUBSTRING(LTRIM(RTRIM(Batch.PerPost)), 5, 2)) AS PrintMonth   --grab the period (last two chars)
		, (SUBSTRING(LTRIM(RTRIM(Batch.PerPost)), 1, 4)) AS PrintYear   --grab the year (1st four chars)
		, (CASE WHEN @prior = 0 THEN smContractRev.RevAmount    -- Zero is FALSE
			     ELSE 0.0
	                END) AS CurRevenue
		, (CASE WHEN @prior = 0 THEN 0.0    -- Zero is FALSE
			     ELSE smContractRev.RevAmount
		        END) AS PriorRevenue
		, (CASE WHEN smAgreement.AgreementTypeID IS NULL THEN '' ELSE smAgreement.DefaultCallType END) AS CallType
		, (CASE WHEN Customer.CustID IS NULL THEN '' ELSE Customer.ClassID END) AS CustClass
	FROM smContract
		LEFT OUTER JOIN Customer
			ON smContract.CustID = Customer.CustID
		LEFT OUTER JOIN smAgreement
			ON smContract.ContractType = smAgreement.AgreementTypeID
		INNER JOIN smContractRev
			ON smContract.ContractID = smContractRev.ContractID
			AND smContractRev.Status = 'P'
		INNER JOIN Batch
			ON smContractRev.GLBatNbr = Batch.BatNbr
			AND Batch.Module = 'GL'
			AND Batch.PerPost BETWEEN @startperiod AND @endperiod
	WHERE smContract.BranchID LIKE @branchid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContractRev_Sales_Post_1] TO [MSDSL]
    AS [dbo];

