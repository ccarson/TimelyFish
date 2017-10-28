 CREATE PROC SCM_Update_SOLine_BOQtys
	@CpnyID		varchar(10),	-- Company ID
	@OrdNbr		varchar(15),	-- Order Number (wildcard permissible)
	@LineRef	varchar(5),	-- Order Line (wildcard permissible)
	@CurDate	smalldatetime	-- Today's Date
AS
	SET NOCOUNT ON

IF PATINDEX('%[%]%', @OrdNbr) = 0
BEGIN
	UPDATE 	SOLine
	SET 	QtyBO = (SELECT ISNULL(SUM(CASE WHEN s.ReqPickDate <= @CurDate
        	THEN (s.QtyOrd - s.QtyShip)
        	ELSE 0
       		END), 0)
				FROM 	SOSched s
			WHERE 	s.CpnyID = l.CpnyID
			  AND 	s.OrdNbr = l.OrdNbr
			  AND 	s.LineRef = l.LineRef
			  AND 	s.QtyOrd > 0
			  AND 	s.Status = 'O'),

 		QtyFuture = (SELECT ISNULL(SUM(CASE WHEN s.ReqPickDate > @CurDate
        	THEN (s.QtyOrd - s.QtyShip)
		ELSE 0
		END), 0)
				FROM 	SOSched s
			WHERE 	s.CpnyID = l.CpnyID
			  AND 	s.OrdNbr = l.OrdNbr
			  AND 	s.LineRef = l.LineRef
			  AND 	s.QtyOrd > 0
			  AND 	s.Status = 'O')

	FROM SOLine l

	JOIN SOHeader h
 	  ON h.CpnyID = l.CpnyID
 	 AND h.OrdNbr = l.OrdNbr

	JOIN SOType t
	  ON t.CpnyID = h.CpnyID
	 AND t.SOTypeID = h.SOTypeID

	WHERE h.CpnyID = @CpnyID
	  AND h.OrdNbr = @OrdNbr
	  AND l.LineRef + '' LIKE @LineRef
	  AND h.Status = 'O'
	  AND l.Status = 'O'
	  AND l.QtyOrd > 0
	  AND t.Behavior IN ('CS', 'INVC', 'MO', 'RMA', 'RMSH', 'SO', 'TR', 'WC', 'WO')
END
ELSE
BEGIN
	UPDATE 	SOLine
	SET 	QtyBO = (SELECT ISNULL(SUM(CASE WHEN s.ReqPickDate <= @CurDate
        	THEN (s.QtyOrd - s.QtyShip)
        	ELSE 0
       		END), 0)
				FROM 	SOSched s
			WHERE 	s.CpnyID = l.CpnyID
			  AND 	s.OrdNbr = l.OrdNbr
			  AND 	s.LineRef = l.LineRef
			  AND 	s.QtyOrd > 0
			  AND 	s.Status = 'O'),

 		QtyFuture = (SELECT ISNULL(SUM(CASE WHEN s.ReqPickDate > @CurDate
        	THEN (s.QtyOrd - s.QtyShip)
		ELSE 0
		END), 0)
				FROM 	SOSched s
			WHERE 	s.CpnyID = l.CpnyID
			  AND 	s.OrdNbr = l.OrdNbr
			  AND 	s.LineRef = l.LineRef
			  AND 	s.QtyOrd > 0
			  AND 	s.Status = 'O')

	FROM SOLine l

	JOIN SOHeader h
 	  ON h.CpnyID = l.CpnyID
 	 AND h.OrdNbr = l.OrdNbr

	JOIN SOType t
	  ON t.CpnyID = h.CpnyID
	 AND t.SOTypeID = h.SOTypeID

	WHERE h.CpnyID = @CpnyID
	  AND h.OrdNbr + '' LIKE @OrdNbr
	  AND l.LineRef + '' LIKE @LineRef
	  AND h.Status = 'O'
	  AND l.Status = 'O'
	  AND l.QtyOrd > 0
	  AND t.Behavior IN ('CS', 'INVC', 'MO', 'RMA', 'RMSH', 'SO', 'TR', 'WC', 'WO')
END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Update_SOLine_BOQtys] TO [MSDSL]
    AS [dbo];

