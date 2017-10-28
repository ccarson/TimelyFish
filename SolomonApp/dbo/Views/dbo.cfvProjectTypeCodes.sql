CREATE  VIEW cfvProjectTypeCodes
AS
--*************************************************************
--	Purpose: Project Type
--	Author: Eric Lind
--	Date: 6/9/05
--	Usage:  Report PA030pt.rpt
--*************************************************************
SELECT pjproj.project, pjcode.code_value, pjcode.code_value_desc
	FROM pjproj
	JOIN pjcode ON pjcode.code_value = left(pjproj.project,2)
	WHERE pjcode.code_type = 'PT'
