 CREATE PROCEDURE DMG_SOSched_COIS
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@InvtIDParm	varchar(30),
	@SiteIDParm	varchar(10)
AS
  IF RTRIM(@CpnyID) = '%' OR RTRIM(@OrdNbr) = '%'
	SELECT	*
	FROM	SOSched s
	WHERE	s.CpnyID like @CpnyID
	  AND	s.OrdNbr like @OrdNbr
	  AND   EXISTS
		(	SELECT *
			FROM SOLine l
			WHERE		l.CpnyID = s.CpnyID
				AND	l.OrdNbr = s.OrdNbr
				AND	l.LineRef = s.LineRef
				AND	l.InvtID LIKE @InvtIDParm
				AND	l.SiteID LIKE @SiteIDParm
                AND l.OrdNbr LIKE @OrdNbr
                AND l.CpnyID LIKE @CpnyID
		)
	ORDER BY CpnyID, OrdNbr, LineRef, SchedRef
  ELSE
	SELECT	*
	FROM	SOSched s
	WHERE	s.CpnyID = @CpnyID
	  AND	s.OrdNbr = @OrdNbr
	  AND   EXISTS
		(	SELECT *
			FROM SOLine l
			WHERE		l.CpnyID = s.CpnyID
				AND	l.OrdNbr = s.OrdNbr
				AND	l.LineRef = s.LineRef
				AND	l.InvtID LIKE @InvtIDParm
				AND	l.SiteID LIKE @SiteIDParm
                AND l.OrdNbr = @OrdNbr
                AND l.CpnyID = @CpnyID
		)
	ORDER BY CpnyID, OrdNbr, LineRef, SchedRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOSched_COIS] TO [MSDSL]
    AS [dbo];

