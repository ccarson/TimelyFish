 

-- LOCATION-LOTSERMST-LSM - LotSerMst has no Location 
-- LOCATION-LOTSERMST-RSM - Location record has no LotSerMst
-- LOCATION-LOTSERMST-QTY - Quantities do not balance
CREATE VIEW vcc_IN_Location_LotSerMst
AS

	SELECT
		errcode = CAST( CASE 
			WHEN m.InvtID IS NULL
			THEN 'LOCATION-LOTSERMST-RSM' -- Location record has no LotSerMst
			ELSE 'LOCATION-LOTSERMST-QTY' -- Quantities do not balance
			END AS VARCHAR(50)),
		siteid = l.Siteid,
		whseloc = l.Whseloc,
		invtid = l.Invtid,
		Location_QtyOnHand = ROUND(l.qtyonhand, p.DecplQty ),
		LotSerMst_QtyOnHand = SUM( COALESCE( ROUND(m.QtyOnHand, p.DecplQty ), 0 ) )
	FROM
		Location l 
	JOIN 
		Inventory i 
			ON l.invtid = i.invtid
    JOIN
        INSetup p ON 1=1
	LEFT OUTER JOIN
		LotserMst m
			ON l.invtid = m.invtid
			AND l.siteid = m.siteid
			AND l.whseloc = m.whseloc
	WHERE 
		i.lotsertrack IN ('LI','SI')
	  	AND 
	  	i.Serassign = 'R'
	GROUP BY 
		l.Invtid,
		l.Siteid,
		l.Whseloc,
		l.QtyOnHand,
		m.InvtID,
		p.DecplQty
	HAVING 
		SUM( COALESCE( ROUND( m.QtyOnHand, p.DecplQty ), 0 ) ) <> ROUND( l.qtyonhand, p.DecplQty )
UNION
	SELECT
		errcode = CAST( 'LOCATION-LOTSERMST-LSM' AS VARCHAR(50)), -- LotSerMst has no Location 
		siteid = m.Siteid,
		whseloc = m.Whseloc,
		invtid = m.Invtid,
		Location_QtyOnHand = NULL,
		LotSerMst_QtyOnHand = ROUND(m.QtyOnHand, p.DecplQty )
	FROM
		LotserMst m
	JOIN 
		Inventory i 
			ON m.invtid = i.invtid
    JOIN
        INSetup p ON 1=1
	WHERE 
		i.lotsertrack IN ('LI','SI')
	  	AND 
	  	i.Serassign = 'R'
		AND
		NOT EXISTS 
		(
			SELECT * 
			FROM 
				Location l 
			WHERE 		
				l.invtid = m.invtid
				AND 
				l.siteid = m.siteid
				AND 
				l.whseloc = m.whseloc
		)


 
