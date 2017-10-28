
create PROC [dbo].[cfpPJPOJLookupPV]
	@PARM1 varchar(30)
	AS
	-- ********************************
	-- Created 3/9/2015 by BMD to support PAPROJ00 Screen parent site lookup (pjproj.user2)
	-- ********************************
	Select *
	from PJPROJ where left(project,2) in ('PS', 'CF') and project_desc <> ''
	order by status_pa, project


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpPJPOJLookupPV] TO [MSDSL]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfpPJPOJLookupPV] TO [MSDSL]
    AS [dbo];

