
CREATE view [dbo].[QueryViewList]
as

select   
	rtrim(vs_modules.ModuleName) 'Module',
	rtrim(vs_screen.name) 'Number',
	rtrim(vs_qvcatalog.QueryViewName) 'QueryViewName',
	rtrim(vs_qvcatalog.ViewDescription) 'ViewDescription',
	CASE WHEN vs_qvcatalog.BaseQueryView = vs_qvcatalog.QueryViewName THEN 1 ELSE 0 END [IsBaseQueryView]
		
	from vs_qvcatalog
	inner join vs_modules on vs_modules.ModuleCode = vs_qvcatalog.Module
	inner join vs_screen on vs_screen.number = vs_qvcatalog.Number

