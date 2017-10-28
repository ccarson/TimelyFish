Create proc pCreateMergeTable
		@TblName as varchar(50)
AS

WHILE 1=0
BEGIN
	CREATE TABLE [dbo].[@TblName]( ID INT ) ; 
END

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[@TblName]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[@TblName]

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pCreateMergeTable] TO [PRD]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pCreateMergeTable] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pCreateMergeTable] TO [se\analysts]
    AS [dbo];

