 CREATE PROCEDURE SOPJProj_Template
	@Project		varchar( 16 )
AS
	SELECT			*
	FROM			PJPROJ
	WHERE			Project like @Project
				and status_pa = 'G'
	ORDER BY		Project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOPJProj_Template] TO [MSDSL]
    AS [dbo];

