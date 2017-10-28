 

-- ITEMCOST-ITEMSITE-RSM   Intran has no location record.
-- ITEMCOST-ITEMSITE-LSM   Location record has no INTran.
-- ITEMCOST-ITEMSITE-QTY   Quantity on hand is out of balance.
-- ITEMCOST-ITEMSITE-COST  Cost is out of balance.
CREATE VIEW vcc_IN_ItemCost_ItemSite
AS

    SELECT
    	errcode = CASE
    		WHEN s.QtyOnHand <> SUM( COALESCE( c.Qty, 0 ) )
    		THEN CAST( 'ITEMCOST-ITEMSITE-QTY' AS CHAR(50))
    		ELSE CAST( 'ITEMCOST-ITEMSITE-COST' AS CHAR(50))
    		END,
    	s.SiteID,
    	s.InvtID,
    	ItemCost_QtyOnHand = SUM( ROUND( c.Qty, p.DecplQty ) ),
    	ItemSite_QtyOnHand = ROUND( s.QtyOnHand, p.DecplQty ),
    	ItemCost_TotCost = SUM( ROUND( c.TotCost, p.DecPlPrcCst ) ),
    	ItemSite_TotCost =  ROUND( s.TotCost, p.DecPlPrcCst )
    FROM
    	ItemSite s
	JOIN
		INSetup p ON 
		    1 = 1
    JOIN
    	Inventory i ON
    		s.InvtID = i.InvtID
    JOIN
    	ItemCost c ON 
    		s.InvtID = c.InvtID 
    		AND 
    		s.SiteID = c.SiteID
    WHERE
    	i.ValMthd IN ( 'L', 'F', 'S') -- FIFO, LIFO, Specific ID
    GROUP BY
    	s.SiteID, 
    	s.InvtID,
    	s.TotCost,
    	s.QtyOnHand,
    	p.DecplQty,
    	p.DecPlPrcCst
    HAVING
        ABS( SUM( ROUND( c.Qty, p.DecplQty ) ) - ROUND( s.QtyOnHand, p.DecplQty ) ) >= POWER(CAST(10 AS FLOAT), -p.DecplQty )
    	OR
    	ABS( SUM( ROUND( c.TotCost, p.DecPlPrcCst ) ) - ROUND( s.TotCost, p.DecPlPrcCst ) ) >= POWER(CAST(10 AS FLOAT), -p.DecPlPrcCst )
UNION
    SELECT 
        errcode = CAST( 'ITEMCOST-ITEMSITE-RSM' AS VARCHAR(50)), -- Location has no INTran
        c.Siteid,
        c.Invtid,
        ItemCost_QtyOnHand = CAST( SUM( COALESCE( ROUND( c.Qty, p.DecplQty ), 0 ) ) AS FLOAT ),
        ItemSite_QtyOnHand = CAST( NULL AS FLOAT ),
        ItemCost_TotCost = CAST( SUM( COALESCE( ROUND( c.TotCost , p.DecPlPrcCst ), 0 ) ) AS FLOAT ),
        ItemSite_TotCost = CAST( NULL AS FLOAT )
	FROM
		ItemCost c
	JOIN
		INSetup p ON 
		    1 = 1
	WHERE
        NOT EXISTS (
            SELECT 
                *
            FROM
                ItemSite s
            WHERE
            	c.InvtId = s.InvtId
            	AND 
            	c.SiteId = s.SiteId
        )
	GROUP BY
		c.SiteID,
		c.InvtID,
    	p.DecplQty,
    	p.DecPlPrcCst
	HAVING
        0 <> SUM( ABS( COALESCE( ROUND( c.Qty, p.DecplQty ), 0 ) ) )
UNION
    SELECT 
        errcode = CAST( 'ITEMCOST-ITEMSITE-LSM' AS VARCHAR(50)), -- Location has no INTran
        s.Siteid, 
        s.Invtid,
        ItemCost_QtyOnHand = CAST( NULL AS FLOAT ),
        ItemSite_QtyOnHand = ROUND( s.QtyOnHand, p.DecplQty ),
        ItemCost_TotCost = CAST( NULL AS FLOAT ),
        ItemSite_TotCost = ROUND( s.TotCost, p.DecPlPrcCst )
	FROM
		ItemSite s
	JOIN
		INSetup p ON 
		    1 = 1
	JOIN
		Inventory i ON 
    		i.InvtID = s.InvtID
	WHERE
        i.ValMthd IN ( 'L', 'F', 'S') -- FIFO, LIFO, Specific ID
        AND
        ROUND( s.QtyOnHand, p.DecplQty ) <> 0
        AND
        NOT EXISTS (
            SELECT 
                *
            FROM
                ItemCost c
            WHERE
            	c.InvtId = s.InvtId
            	AND 
            	c.SiteId = s.SiteId
        )


 
