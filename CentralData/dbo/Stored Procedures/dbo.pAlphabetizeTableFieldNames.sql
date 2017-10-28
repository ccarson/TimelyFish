create proc pAlphabetizeTableFieldNames
	    @TableName as varchar(50)
AS
BEGIN
DECLARE FieldNames_Cursor CURSOR 
FOR 
	SELECT TOP 100 PERCENT SC.name AS FieldName
	FROM dbo.syscolumns SC WITH (NOLOCK) 
	WHERE (OBJECT_NAME(id) = @TableName)  
	Order by sc.name
OPEN FieldNames_Cursor
DECLARE @strFieldNames  varchar(750)
DECLARE @FieldName varchar(50)
set @strFieldNames=''
set @FieldName=''
FETCH NEXT FROM FieldNames_Cursor INTO @FieldName
Set @strFieldNames=@FieldName + ', '
WHILE @@FETCH_STATUS=0
	BEGIN
	FETCH NEXT FROM FieldNames_Cursor INTO @FieldName
		Set @strFieldNames=@strFieldNames + @FieldName + ', '
	END
CLOSE FieldNames_Cursor
DEALLOCATE FieldNames_Cursor
Set @strFieldNames=left(@strFieldNames,len(@strFieldNames) -len(@FieldName)-3)
Declare @strSql as varchar(2000)
begin
set @strSql='Select ' + @strFieldNames + ', getdate() as Crtd_DateTime,
	getdate() as Crtd_User , getdate() as Lupd_User, getDate() as Crtd_Prog, getDate() as Lupd_Prog , getdate() as Lupd_DateTime
	into [$(SolomonApp)].dbo.cft' + rtrim(@TableName) + ' from ' + @TableName
print @strSql
exec(@strSql)
end 

END
