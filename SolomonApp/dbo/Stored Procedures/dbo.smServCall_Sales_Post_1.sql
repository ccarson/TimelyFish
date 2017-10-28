 CREATE PROCEDURE
	smServCall_Sales_Post_1
                  @startperiod AS VARCHAR (6)
                , @endperiod AS VARCHAR (6)
                , @branchid AS VARCHAR (10)
                , @prior AS BIT
                , @inclnblabor AS SMALLINT
                , @inclnbtm AS SMALLINT
                , @ri_id AS SMALLINT
                , @rectype AS CHAR (1)
AS
	SET NOCOUNT ON
	DECLARE @roundprecision AS SMALLINT
	SELECT @roundprecision = decpl
	FROM currncy c join glsetup on c.curyid = glsetup.basecuryid

	INSERT INTO smWrkSalesAnalysis
		(RI_ID
		, RecType
		, ServiceCallID
		, ServiceContractID
		, CallType
		, CustClass
		, InvoiceType
		, PrintMonth
		, PrintYear
		, CurCost
		, CurHours
		, CurNbrCalls
		, CurRevenue
		, PriorCost
		, PriorHours
		, PriorNbrCalls
		, PriorRevenue)
	SELECT @ri_id AS RI_ID
	     , @rectype AS RecType
	     , smServCall.ServiceCallID AS ServiceCallID
	     , '' AS ServiceContractID
	     , MAX(smServCall.CallType) AS CallType
	     , MAX(Customer.ClassID) AS CustClass
	     , MAX(smServCall.cmbInvoiceType) AS InvoiceType
	     , (SUBSTRING(LTRIM(RTRIM(MAX(smServCall.PostToPeriod))), 5, 2)) AS PrintMonth   --grab the period (last two chars)
	     , (SUBSTRING(LTRIM(RTRIM(MAX(smServCall.PostToPeriod))), 1, 4)) AS PrintYear   --grab the year (1st four chars)
	     , SUM(CASE WHEN @prior = 0 AND smServDetail.ServiceCallID IS NOT NULL THEN    -- Zero is FALSE
	                    CASE WHEN smServDetail.DetailType = 'L' THEN --Labor
	                             CASE WHEN smServDetail.LineTypes = 'N' THEN
	                                      CASE WHEN @inclnblabor = 0 THEN 0.0    -- Zero is FALSE
	                                           ELSE smServDetail.TranAmt
	                                      END
	                                  ELSE smServDetail.TranAmt
	                             END -- CASE LineTypes
	                         ELSE -- WHEN DetailType <> 'L' --Material
	                             CASE WHEN smServDetail.FlatRateID = '' THEN
	                                      CASE WHEN smServDetail.LineTypes = 'N' THEN
	                                               CASE WHEN @inclnbtm = 0 THEN 0.0    -- Zero is FALSE
	                                                    ELSE CASE WHEN smServDetail.Cost = 0.0 THEN ROUND((smServDetail.Quantity * smServDetail.StdCost), @roundprecision)
	                                                              ELSE ROUND((smServDetail.Quantity * smServDetail.Cost), @roundprecision)
	                                                          END
	                                               END
	                                           ELSE -- WHEN LineTypes <> 'N'
	                                               CASE WHEN smServDetail.Cost = 0.0 THEN ROUND((smServDetail.Quantity * smServDetail.StdCost), @roundprecision)
                                                            ELSE ROUND((smServDetail.Quantity * smServDetail.Cost), @roundprecision)
	                                               END
	                                      END -- CASE LineTypes
	                                   ELSE -- WHEN FlatRateID <> ''
	                                       CASE WHEN smServDetail.POCost = 0.0 THEN ROUND((smServDetail.Quantity * smServDetail.InvtStdCost), @roundprecision)
	                                            ELSE ROUND((smServDetail.Quantity * smServDetail.POCost), @roundprecision)
	                                       END
	                             END -- CASE FlatRate
	                    END -- smServDetail.DetailType
	                ELSE 0.0
	           END) AS CurCost
	     , SUM(CASE	WHEN @prior = 0 AND smServDetail.ServiceCallID IS NOT NULL THEN    -- Zero is FALSE
	                    CASE WHEN smServDetail.DetailType = 'L' THEN smServDetail.WorkHr
	                         ELSE 0
	                    END
			ELSE 0
	  END) AS CurHours
	     , (CASE WHEN @prior = 0 THEN 1 ELSE 0 END) AS CurNbrCalls
	     , SUM(CASE	WHEN @prior = 0 AND smServDetail.ServiceCallID IS NOT NULL THEN smServDetail.ExtPrice    -- Zero is FALSE
			ELSE 0.0
	           END) AS CurRevenue
	     , SUM(CASE WHEN @prior = 0 OR smServDetail.ServiceCallID IS NULL THEN 0.0    -- Zero is FALSE
	                ELSE
	                    CASE WHEN smServDetail.DetailType = 'L' THEN --Labor
	                             CASE WHEN smServDetail.LineTypes = 'N' THEN
	                                      CASE WHEN @inclnblabor = 0 THEN 0.0    -- Zero is FALSE
	                                           ELSE smServDetail.TranAmt
	                                      END
		                                  ELSE smServDetail.TranAmt
	                             END -- CASE LineTypes
	                         ELSE -- WHEN DetailType <> 'L' --Material
	                             CASE WHEN smServDetail.FlatRateID = '' THEN
	                                      CASE WHEN smServDetail.LineTypes = 'N' THEN
	                                               CASE WHEN @inclnbtm = 0 THEN 0.0    -- Zero is FALSE
	                                                    ELSE CASE WHEN smServDetail.Cost = 0.0 THEN ROUND((smServDetail.Quantity * smServDetail.StdCost), @roundprecision)
	                                                              ELSE ROUND((smServDetail.Quantity * smServDetail.Cost), @roundprecision)
        	                                                  END
	                                               END
	                                           ELSE -- WHEN LineTypes <> 'N'
	                                               CASE WHEN smServDetail.Cost = 0.0 THEN ROUND((smServDetail.Quantity * smServDetail.StdCost), @roundprecision)
	                                                             ELSE ROUND((smServDetail.Quantity * smServDetail.Cost), @roundprecision)
	                                               END
	                                      END -- CASE LineTypes
	                                   ELSE -- WHEN FlatRateID <> ''
	                                       CASE WHEN smServDetail.POCost = 0.0 THEN ROUND((smServDetail.Quantity * smServDetail.InvtStdCost), @roundprecision)
	                                            ELSE ROUND((smServDetail.Quantity * smServDetail.POCost), @roundprecision)
	                                       END
	                             END -- CASE FlatRate
	                    END -- smServDetail.DetailType
	           END) AS PriorCost
	     , SUM(CASE	WHEN @prior = 0 OR smServDetail.ServiceCallID IS NULL THEN 0    -- Zero is FALSE
			ELSE
	                    CASE WHEN smServDetail.DetailType = 'L' THEN smServDetail.WorkHr
	                         ELSE 0
	                    END
	           END) AS PriorHours
	     , (CASE WHEN @prior = 0 THEN 0 ELSE 1 END) AS PriorNbrCalls
	     , SUM(CASE	WHEN @prior = 0 OR smServDetail.ServiceCallID IS NULL THEN 0.0    -- Zero is FALSE
			ELSE smServDetail.ExtPrice
	           END) AS PriorRevenue
	FROM	smServCall
		INNER JOIN Customer
			ON smServCall.CustomerId = Customer.CustId
		LEFT OUTER JOIN smServDetail
			ON smServCall.ServiceCallID = smServDetail.ServiceCallID
				AND smServDetail.BillFlag = 1	-- TRUE
	WHERE	smServCall.PostToPeriod BETWEEN @startperiod AND @endperiod
		AND (smServCall.ServiceCallCompleted = 1   -- TRUE
			OR smServCall.cmbCODInvoice = 'P')
		AND smServCall.BranchID LIKE @branchid
	GROUP BY smServCall.ServiceCallID


