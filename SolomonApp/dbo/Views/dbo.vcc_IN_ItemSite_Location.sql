 


-- ITEMSITE-LOCATION-QTY	Quantities out of balance.
-- ITEMSITE-LOCATION-RSM	LotSerMst has no LotSerT.
-- ITEMSITE-LOCATION-LSM	LotSerT has no LotSerMst.
CREATE VIEW vcc_IN_ItemSite_Location
AS

	SELECT
		errcode = CAST( CASE 
			WHEN s.InvtID IS NULL
			THEN 'ITEMSITE-LOCATION-LSM' -- Location record has no ItemSite
			ELSE 'ITEMSITE-LOCATION-QTY' -- Quantities do not balance
			END AS VARCHAR(50)),
		siteid = l.siteid,
		invtid = l.invtid,
		ItemSite_QtyOnHand = COALESCE( ROUND( s.qtyonhand,p.DecplQty), 0 ),
		Location_QtyOnHand = SUM( COALESCE( ROUND(l.QtyOnHand,p.DecplQty), 0 ) )
	FROM
		Location l
	JOIN
		INSetup p ON 1=1
	LEFT OUTER JOIN
		ItemSite s
			ON
			l.invtid = s.invtid
			AND
			l.siteid = s.siteid
	GROUP BY
		l.siteid, l.invtid, s.invtid, p.DecplQty, s.qtyonhand
	HAVING
		SUM( COALESCE( ROUND(l.QtyOnHand,p.DecplQty), 0 ) ) <> COALESCE( ROUND(s.qtyonhand,p.DecplQty), 0 )
UNION
	SELECT
		errcode = CAST( 'ITEMSITE-LOCATION-RSM' AS VARCHAR(50)), -- ItemSite has no Location
		siteid = s.Siteid,
		invtid = s.Invtid,
		ItemSite_QtyOnHand = ROUND(s.QtyOnHand, p.DecplQty),
		Location_QtyOnHand = 0
	FROM
		ItemSite s
	JOIN
		INSetup p ON 1=1
	WHERE
		NOT EXISTS 
		(
			SELECT 
				* 
			FROM 
				Location l 
			WHERE
				l.invtid = s.invtid
				AND
				l.siteid = s.siteid
		)
        AND
        s.QtyOnHand <> 0

 
