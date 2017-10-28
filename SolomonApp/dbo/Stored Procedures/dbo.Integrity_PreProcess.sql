 CREATE PROCEDURE Integrity_PreProcess
AS
	SET	NOCOUNT ON

/*
	Delete all INTRAN records that contain invalid Inventory IDs.
*/
	DELETE	FROM INTRAN
		FROM	INTRAN LEFT JOIN INVENTORY
			ON INTRAN.INVTID = INVENTORY.INVTID
		WHERE	INVENTORY.INVTID IS NULL
/*
	Deletes any LotSerMst records that shouldn't exist for invalid items.
*/
	DELETE	FROM	LOTSERMST
		FROM	LOTSERMST LEFT JOIN INVENTORY
			ON LOTSERMST.INVTID = INVENTORY.INVTID
		WHERE	INVENTORY.INVTID IS NULL
/*
	Delete any LOCATION records that shouldn't exist.
*/
	DELETE	FROM LOCATION
		FROM 	LOCATION LEFT JOIN INVENTORY
			ON LOCATION.INVTID = INVENTORY.INVTID
		WHERE	INVENTORY.INVTID IS NULL

/*
	Delete any ITEMSITE records that shouldn't exist.
*/
	DELETE	FROM ITEMSITE
		FROM 	ITEMSITE LEFT JOIN INVENTORY
			ON ITEMSITE.INVTID = INVENTORY.INVTID
		WHERE	INVENTORY.INVTID IS NULL

/*
	Creates a temporary table to hold the listing of Inventory Items and Sites that have a combined
	quantity on hand of zero.
*/
	CREATE	TABLE #LOTCLR (INVTID VARCHAR(30), SITEID VARCHAR(10))
/*
	Populate the with the InvtID and SiteID combinations that total to zero in LotSerMst.
*/
	INSERT	INTO #LOTCLR
		(INVTID, SITEID)
	SELECT	INVTID, SITEID
		FROM	VP_DECPL PL, LOTSERMST
		WHERE	ROUND(QTYONHAND, PL.DECPLQTY) <> 0
		GROUP BY INVTID, SITEID, PL.DECPLQTY
		HAVING ROUND(SUM(QTYONHAND), PL.DECPLQTY) = 0
/*
	Join LotSerMst and the temporary table to know which LotSerMst records need to be zeroed.
*/
	UPDATE	LOTSERMST
		SET	QTYONHAND = 0
		FROM	#LOTCLR LOT JOIN LOTSERMST
			ON LOT.INVTID = LOTSERMST.INVTID
			AND LOT.SITEID = LOTSERMST.SITEID
/*
	Delete the temporary Table, it is no longer needed.
*/
	DROP TABLE #LOTCLR

/*
	Creates a temporary table to hold the listing of Inventory Items, Sites and LotSerNbr that have a combined
	quantity on hand of zero.
*/
	CREATE	TABLE #LOTNBRCLR (INVTID VARCHAR(30), SITEID VARCHAR(10), LOTSERNBR VARCHAR(25))
/*
	Populate the with the InvtID, SiteID and LotSerNbr combinations that total to zero in LotSerMst.
*/
	INSERT	INTO #LOTNBRCLR
		(INVTID, SITEID, LOTSERNBR)
		SELECT	INVTID, SITEID, LOTSERNBR
			FROM	VP_DECPL PL, LOTSERMST
			WHERE	ROUND(QTYONHAND, PL.DECPLQTY) <> 0
			GROUP BY INVTID, SITEID, LOTSERNBR, PL.DECPLQTY
			HAVING ROUND(SUM(QTYONHAND), PL.DECPLQTY) = 0

/*
	Join LotSerMst and the temporary table to know which LotSerMst records need to be zeroed.
*/
	UPDATE	LOTSERMST
		SET	QTYONHAND = 0
		FROM	#LOTNBRCLR LOT JOIN LOTSERMST
			ON LOT.INVTID = LOTSERMST.INVTID
			AND LOT.SITEID = LOTSERMST.SITEID
			AND LOT.LOTSERNBR = LOTSERMST.LOTSERNBR

/*
	Delete the temporary Table, it is no longer needed.
*/
	DROP TABLE #LOTNBRCLR


