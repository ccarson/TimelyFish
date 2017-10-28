 CREATE PROCEDURE
	smWrkSalesAnalysis_CurrentMonth
                @ri_id AS SMALLINT
              , @month AS SMALLINT
AS
	SET NOCOUNT ON
	INSERT INTO smWrkSalesAnalysis
		(CallType
		, CurCost
		, CurHours
		, CurNbrCalls
		, CurRevenue
		, CustClass
		, InvoiceType
		, PrintMonth
		, PrintYear
		, PriorCost
		, PriorHours
		, PriorNbrCalls
		, PriorRevenue
		, RecType
		, RI_ID
		, ServiceCallID
		, ServiceContractId)
	SELECT CallType
		, CurCost
		, CurHours
		, CurNbrCalls
		, CurRevenue
		, CustClass
		, InvoiceType
		, PrintMonth
		, PrintYear
		, PriorCost
		, PriorHours
		, PriorNbrCalls
		, PriorRevenue
		, 'M'
		, RI_ID
		, ServiceCallID
		, ServiceContractId
	FROM smWrkSalesAnalysis
	WHERE RI_ID = @ri_id
		AND PrintMonth = @month
		AND RecType <> 'M'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smWrkSalesAnalysis_CurrentMonth] TO [MSDSL]
    AS [dbo];

