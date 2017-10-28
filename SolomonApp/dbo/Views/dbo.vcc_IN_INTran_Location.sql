 

-- INTRAN-LOCATION-RSM  Intran has no location record
-- INTRAN-LOCATION-LSM  Location record has no INTran
-- INTRAN-LOCATION-QTY  Quantity on hand is out of balance
CREATE VIEW vcc_IN_INTran_Location
AS

    SELECT 
		errcode = CAST( CASE 
			WHEN l.QtyOnHand IS NULL
			THEN 'INTRAN-LOCATION-RSM' -- Location record has no INTran
			ELSE 'INTRAN-LOCATION-QTY' -- Quantities do not balance
			END AS VARCHAR(50)),
        t.Siteid, 
        t.WhseLoc, 
        t.Invtid,
        Intran_Qty = SUM(
            CASE 
                WHEN t.CnvFact = 0 
                THEN 
                    ROUND((t.Qty * t.InvtMult), i.DecPlQty)
                ELSE 
                    CASE 
                        WHEN t.UnitMultDiv = 'D' 
                        THEN (ROUND((T.Qty / T.CnvFact), i.DecPlQty) * t.InvtMult) 
                        ELSE (ROUND((T.Qty * T.CnvFact), i.DecPlQty) * t.InvtMult) 
                        END
                END),
        Location_QtyOnHand = l.QtyOnHand
    FROM
        INTran t 
    LEFT OUTER JOIN 
        Location l
    ON
        t.InvtId = l.InvtId
        AND
        t.SiteId = l.SiteId
        AND 
        t.WhseLoc = l.WhseLoc
    JOIN 
        INSetup i ON 1 = 1       
    WHERE 
        t.TranType NOT IN ('CT', 'CG')
        AND 
        t.Rlsed = 1
        AND 
        t.S4Future09 = 0 -- Select only stock items.
    GROUP BY 
        t.SiteId, 
        t.WhseLoc, 
        t.InvtId, 
        l.QtyOnHand
    HAVING 
        COALESCE(l.QtyOnHand,0) <> SUM(
        CASE 
            WHEN t.CnvFact = 0 
            THEN 
                ROUND((t.Qty * t.InvtMult), i.DecPlQty)
            ELSE 
                CASE 
                    WHEN t.UnitMultDiv = 'D' 
                    THEN (ROUND((T.Qty / T.CnvFact), i.DecPlQty) * t.InvtMult) 
                    ELSE (ROUND((T.Qty * T.CnvFact), i.DecPlQty) * t.InvtMult) 
                    END
            END)
        
UNION
    SELECT 
        errcode = CAST( 'INTRAN-LOCATION-LSM' AS VARCHAR(50)), -- Location has no INTran
        l.Siteid, 
        l.WhseLoc, 
        l.Invtid,
        Intran_Qty = NULL,
        Location_QtyOnHand = l.QtyOnHand
	FROM
		Location l 
	WHERE
	    l.QtyOnHand <> 0
	    AND
		NOT EXISTS (
			SELECT 
			    *
			FROM
			    INTran t
			WHERE
				t.InvtId = l.InvtId
				AND 
				t.SiteId = l.SiteId
				AND 
				t.WhseLoc = l.WhseLoc
		)


 
