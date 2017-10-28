 

-- INTRAN-LOTSERT-LSM	LotSerT has no INTran.
-- INTRAN-LOTSERT-RSM	INTran has no LotSerT.
-- INTRAN-LOTSERT-QTY	Quantities out of balance.
CREATE VIEW vcc_IN_INTran_LotSerT
AS

	SELECT
		errcode = 'INTRAN-LOTSERT-LSM', -- LotSerT has no INTran record.
		batnbr = l.batnbr,
		lineref = l.intranlineref,
		siteid = l.siteid,
		whseloc = l.whseloc, 
		invtid = l.invtid,
		lotsernbr = l.lotsernbr,
		INTran_Qty = NULL,
		LotSerT_Qty =  l.Qty * l.InvtMult, 
		INTran_RecordID = NULL,
		LotSerT_RecordID = l.RecordID
	FROM
		LotSerT l
	WHERE 
		NOT EXISTS(
			SELECT	
				*
			FROM
				INTran e
			WHERE
				e.BatNbr = l.BatNbr
				AND
				e.LineRef = l.INTranLineRef
				and
				e.TranType NOT IN ('CT','CG')
		)
	UNION
	SELECT
		errcode = 'INTRAN-LOTSERT-RSM', -- INTran has no LotSerT.
		batnbr = e.batnbr,
		lineref = e.lineref,
		siteid = e.siteid,
		whseloc = e.whseloc, 
		invtid = e.invtid,
		lotsernbr = NULL,
		INTran_Qty = e.Qty * e.InvtMult,
		LotSerT_Qty = NULL,
		INTran_RecordID = e.RecordID,
		LotSerT_RecordID = NULL
	FROM
		INTran e
	JOIN	
		Inventory i ON i.InvtID = e.InvtID
	WHERE 
		e.TranType NOT IN ('CT','CG')
		AND
		i.lotsertrack IN ('LI','SI')
		AND
		e.S4Future09 = 0 -- Select out only non stock items.
		AND 
		NOT EXISTS(
			SELECT	
				*
			FROM
				LotSerT l
			WHERE
				e.BatNbr = l.BatNbr
				AND
				l.BatNbr <> ''
				AND
				CAST( e.LineRef AS INT) = CAST(l.INTranLineRef AS INT)
		)
	UNION
	SELECT
		errcode = 'INTRAN-LOTSERT-QTY',
		batnbr = e.batnbr,
		lineref = e.lineref,
		siteid = e.siteid,
		whseloc = e.whseloc,
		invtid = e.invtid,
		lotsernbr = NULL,
		INTran_Qty = e.Qty * e.InvtMult,
		LotSerT_Qty = SUM( l.Qty * l.InvtMult ),
		INTran_RecordID = e.RecordID,
		LotSerT_RecordID = NULL
	
	FROM
		INTran e
	JOIN
		LotSerT l ON 
			e.BatNbr = l.BatNbr
			AND
			e.LineRef = l.INTranLineRef
			AND
			e.InvtID = l.InvtID
			AND
			e.SiteID = l.SiteID
			AND
			e.WhseLoc = l.WhseLoc
	WHERE
		e.TranType NOT IN ('CT','CG')
		and
		e.S4Future09 = 0 -- Select out only non stock items.
	GROUP BY
		e.RecordID, e.batnbr, e.lineref, e.invtid,  e.siteid, e.whseloc, e.trantype, e.qty, e.invtmult, e.TranDate
	HAVING
		e.Qty * e.InvtMult <> SUM( l.Qty * l.InvtMult )
		


 
