 CREATE PROCEDURE SOPJProj_spk5_No_WO
	@Project		varchar( 16 )
AS
	SELECT			*
	FROM			PJPROJ
	WHERE			Project like @Project
				and status_pa = 'A'
				and status_ar = 'A'
				and status_20 = '' 		-- WOs have Status_20 filled with WOType
	ORDER BY		Project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOPJProj_spk5_No_WO] TO [MSDSL]
    AS [dbo];

