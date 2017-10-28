create proc dbo.GetDelimitedFieldList
	@TableName As varchar(30)
	As
	SET NOCOUNT ON
	DECLARE @FieldName As varchar(30)
	DECLARE @FieldListStr As varchar(2000)
	DECLARE @FieldCount As Int
	DECLARE @Remainder As Int
	DECLARE csr_FieldList CURSOR FOR Select Name
		FROM syscolumns 
		where id = (select object_id(@TableName))
		order by colorder
	Select @FieldListStr = ''
	Select @FieldName = ''
	Select @FieldCount = 0
	Select @Remainder = 0
	OPEN csr_FieldList
	FETCH NEXT FROM csr_FieldList INTO @FieldName
	WHILE @@FETCH_STATUS = 0
		BEGIN
		Select @FieldCount = @FieldCount + 1
		Select @FieldListStr = RTrim(@FieldListStr) + RTrim(@FieldName) + ','
			BEGIN
			SELECT @Remainder = @FieldCount % 8
			IF @Remainder = 0 And RTrim(@FieldName) <> 'tstamp'
				Select @FieldListStr = @FieldListStr + char(13)
			END
		FETCH NEXT FROM csr_FieldList INTO @FieldName
		END
	CLOSE csr_FieldList
	DEALLOCATE csr_FieldList
	Select @FieldListStr = SubString(@FieldListStr, 1, Len(RTrim(@FieldListStr))-8)
	PRINT @FieldListStr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetDelimitedFieldList] TO [MSDSL]
    AS [dbo];

