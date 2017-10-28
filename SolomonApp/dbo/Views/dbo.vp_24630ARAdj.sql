

create view vp_24630ARAdj as 
-- Totalling all discounts taken...ever.
-- Only adding in adjustments from the requested period and before.

SELECT r.RI_ID, j.CustId, j.AdjdDocType, j.AdjdRefNbr,
		SUM(j.AdjDiscAmt + (case when r.EndPerNbr >= j.PerAppl then j.AdjAmt else 0 end)) AdjAmt,
		SUM(j.CuryAdjdDiscAmt + (case when r.EndPerNbr >= j.PerAppl then j.CuryAdjdAmt else 0 end)) CuryAdjdAmt
	FROM RptRuntime r, ARAdjust j
	WHERE r.ReportNbr = '24630'
		and j.AdjdDocType in ('FI', 'IN', 'DM', 'CM')
	GROUP BY r.RI_ID, j.CustId, j.AdjdDocType, j.AdjdRefNbr


