
create view XDD_vp_LB_Customer
AS
	SELECT 		C.CustID,
			C.Name,
			(Select Coalesce(Sum(CuryDocBal),0) FROM ARDoc Where CustID = C.CustID
			   	and OpenDoc = 1
				and CuryDocBal > 0
				and DocType = 'IN') As Invoice,
			(Select Coalesce(Sum(CuryDocBal),0) FROM ARDoc Where CustID = C.CustID
			   	and OpenDoc = 1
				and CuryDocBal > 0
				and DocType = 'DM') As DebitMemo,
			(Select Coalesce(Sum(CuryDocBal),0) FROM ARDoc Where CustID = C.CustID
			   	and OpenDoc = 1
				and CuryDocBal > 0
				and DocType = 'FI') As FinanceCharge,
			(Select Coalesce(Sum(CuryDocBal),0) FROM ARDoc Where CustID = C.CustID
			   	and OpenDoc = 1
				and CuryDocBal > 0
				and DocType = 'CM') As CreditMemo,
			C.Addr1,
			C.City,
			C.Zip,
			C.State,
			C.Phone
	FROM		Customer C LEFT OUTER JOIN ARDoc D
			ON C.CustId = D.CustID
	WHERE		D.DocType IN ('IN', 'DM', 'FI', 'CM')
			and D.CuryDocBal > 0
	GROUP BY	C.CustID, C.Name, C.Addr1, C.City, C.State, C.Zip, C.Phone
