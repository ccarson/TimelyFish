 CREATE Procedure wcpv_SalesPerson(
	@SlsPerID VARCHAR(10) = '%'
)As
	SELECT	s.Name, s.SlsPerID
	FROM	SalesPerson s (NOLOCK)
	WHERE	s.SlsPerID LIKE @SlsPerID
	ORDER BY s.Name



GO
GRANT CONTROL
    ON OBJECT::[dbo].[wcpv_SalesPerson] TO [MSDSL]
    AS [dbo];

