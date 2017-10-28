
CREATE PROCEDURE WSL_ViewColumns @viewName sysname
AS
select sc.name as column_name, st.name as [type_name]
from sys.columns sc
	join sys.types st on sc.system_type_id = st.system_type_id
where sc.[object_id] = object_id(@viewName) order by sc.column_id
