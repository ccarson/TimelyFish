 CREATE Procedure wcpv_SOType(
	@CpnyID VARCHAR(10) = '%',
	@SOTypeID VARCHAR(4) = '%'
)As
	SELECT	RTRIM(s.Descr) as Descr, s.CpnyID, s.SOTypeID
	FROM	SOType s
	WHERE	s.CpnyID LIKE @CpnyID
	AND	s.SOTypeID LIKE @SOTypeID
	ORDER BY s.Descr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[wcpv_SOType] TO [MSDSL]
    AS [dbo];

