 CREATE PROCEDURE smSumTables_10400
	@BatchNbr CHAR(10)
AS
		/* Update the Material Cost Total and Labor Cost total in the smServCall table */

		DECLARE @SvcCallID AS CHAR(10)
		DECLARE @TotMatCost MONEY
		DECLARE @TotLaborCost MONEY

		DECLARE smServDetail_Cursor CURSOR
   			FOR SELECT DISTINCT ServiceCallID
			FROM smServDetail WHERE INBatNbr = @BatchNbr
  			 ORDER BY ServiceCallID

		OPEN smServDetail_Cursor

		FETCH NEXT FROM smServDetail_Cursor INTO @SvcCallID

		WHILE @@FETCH_STATUS = 0
			BEGIN

				SELECT @TotMatCost = 0
				SELECT @TotLaborCost = 0

				SELECT @TotMatCost = (SELECT SUM(smServDetail.TranAmt)
					FROM smServDetail, smServCall, smProServSetup
					WHERE smServDetail.ServiceCallID = @SvcCallID
						AND smServCall.ServiceCallID = @SvcCallID
						AND smServDetail.DetailType = 'M'
						AND ((smProServSetup.InclNBTM = 1)
						     OR
						     (smProServSetup.InclNBTM = 0
						      AND smServDetail.LineTypes <> 'N'	)))
					IF @TotMatCost IS NULL
					SELECT @TotMatCost = 0

				SELECT @TotLaborCost = (SELECT SUM(smServDetail.TranAmt)
					FROM smServDetail, smServCall, smProServSetup
					WHERE smServDetail.ServiceCallID = @SvcCallID
						AND smServCall.ServiceCallID = @SvcCallID
						AND smServDetail.DetailType = 'L'
						AND ((smProServSetup.InclNBLabor = 1)
						     OR
						     (smProServSetup.InclNBLabor = 0
						      AND smServDetail.LineTypes <> 'N')))

				IF @TotLaborCost IS NUll
					SELECT @TotLaborCost = 0

				/* PRINT @SvcCallID + CONVERT(CHAR, @TotMatCost) + CONVERT(CHAR, @TotLaborCost) */
					UPDATE smServCall
					SET CostFRTM = @TotMatCost, CostLabor = @TotLaborCost
					WHERE smServCall.ServiceCallID = @SvcCallID
					FETCH NEXT FROM smServDetail_Cursor INTO @SvcCallID

			END

		CLOSE smServDetail_Cursor
		DEALLOCATE smServDetail_Cursor


