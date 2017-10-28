 

-- Reports discrepancies between LotSerT and LotSerMst	
-- LOTSERMST-LOTSERT-QTY	Quantities out of balance.
-- LOTSERMST-LOTSERT-RSM	LotSerMst has no LotSerT.
-- LOTSERMST-LOTSERT-LSM	LotSerT has no LotSerMst.
CREATE VIEW vcc_IN_LotSerMst_LotSerT
AS

	SELECT
		errcode = CAST( CASE 
			WHEN t.LotSerNbr IS NULL
			THEN 'LOTSERMST-LOTSERT-LSM' -- No LotSerMst record
			ELSE 'LOTSERMST-LOTSERT-QTY' -- LOTSERMST-LOTSERT-QTY
			END AS CHAR(50)),
		siteid = t.Siteid,
		whseloc = t.WhseLoc,
		invtid = t.Invtid,
		lotsernbr = t.LotSerNbr, 
		LotSerT_Qty = ROUND(SUM(ROUND((t.Qty * t.InvtMult), p.DecplQty )), p.DecplQty ),
		LotSerMst_QtyOnHand = COALESCE( ROUND(m.QtyOnHand, p.DecplQty ), 0 )
	FROM
		LotSerT t
    JOIN
        INSetup p ON 1=1
	LEFT OUTER JOIN 
		LotSerMst m 
			ON
			t.InvtId = m.InvtId
			AND
			t.SiteId = m.SiteId
			AND
			t.WhseLoc = m.WhseLoc
			AND
			t.LotSerNbr = m.LotSerNbr
	WHERE 
		t.Rlsed = 1
	GROUP BY 
		t.InvtId, 
		t.SiteId, 
		t.WhseLoc, 
		t.LotSerNbr,
		m.QtyOnHand,
		p.DecplQty
	HAVING
		ROUND(SUM(ROUND((t.Qty * t.InvtMult), p.DecplQty )), p.DecplQty ) <> COALESCE(ROUND(m.QtyOnHand, p.DecplQty ),0)
UNION
	SELECT 
		errcode = CAST('LOTSERMST-LOTSERT-RSM' AS CHAR(50)), -- No LotSerT record
		siteid = m.SiteID, 
		whseloc = m.WhseLoc, 
		invtid = m.InvtID, 
		lotsernbr = m.LotSerNbr,
		LotSerT_Qty = NULL,
		LotSerMst_QtyOnHand = ROUND(m.QtyOnHand, p.DecplQty )
	FROM 
		LOTSERMST m
    JOIN
        INSetup p ON 1=1
	WHERE
		m.QtyOnHand <> 0 
		AND
		NOT EXISTS 
		(
			SELECT * 
			FROM 
				LOTSERT t
			WHERE
				t.Rlsed = 1
				AND
				t.InvtId = m.InvtId
				AND 
				t.SiteId = m.SiteId
				AND 
				t.WhseLoc = m.WhseLoc
				AND 
				t.LotSerNbr = m.LotSerNbr
		)


 
