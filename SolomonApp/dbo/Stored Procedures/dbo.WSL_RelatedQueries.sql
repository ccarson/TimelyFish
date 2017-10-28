
CREATE PROCEDURE WSL_RelatedQueries @baseQueryView char(50)
AS
select QueryViewName, ViewDescription, CASE WHEN vs_qvcatalog.BaseQueryView = vs_qvcatalog.QueryViewName THEN 1 ELSE 0 END [IsBaseQueryView]
from vs_qvcatalog where BaseQueryView = @baseQueryView
