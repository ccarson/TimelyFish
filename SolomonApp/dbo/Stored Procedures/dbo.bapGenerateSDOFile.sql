CREATE PROCEDURE [dbo].[bapGenerateSDOFile] (@TableName varchar(30))
	AS
	-----------------------------------------------------------------------------------------------------
	-- PURPOSE:		This procedure is used to create a VB SDO file for use in the SL SDK development
	--				environment.
	-- CREATED BY:	Boyer & Associates, Inc. (TJones)
	-- CREATED ON:	4/23/2009
	-- COMMENTS:	To Use this procedure pass the table/view name in as the parameter, then save the output
	--				text to a file TableName.dh.vb - substitued "TABLENAME" with the appropriate real name
	-----------------------------------------------------------------------------------------------------

	-- SL Does not support longer names that 20 usually but I put 30 - if you get a "No Setaddr ..." error
	--	try shortening the table to something 19 characters or less

	--SET @TableName = 'xBABgtSetup'
	DECLARE @FieldText varchar(512)
	PRINT 
	CHAR(39) + '------------------------------------------------------------------------------' + CHAR(13) + CHAR(10)+
	CHAR(39) + ' <copyright file="' + @TableName + '.sdo.vb" company="Boyer & Associates, Inc.">' + CHAR(13) + CHAR(10) +
	CHAR(39) + '     Copyright (c) Boyer & Associates, Inc.  All rights reserved.' + CHAR(13) + CHAR(10) + 
	CHAR(39) + ' </copyright>' + CHAR(13) + CHAR(10) +
	CHAR(39) + '------------------------------------------------------------------------------' + CHAR(13) + CHAR(10) + 
	'Option Strict Off' + CHAR(13) + CHAR(10) +
	'Option Explicit On' + CHAR(13) + CHAR(10) +
	'Imports Solomon.Kernel' + CHAR(13) + CHAR(10) + 
	'Module sdo' + @TableName + CHAR(13) + CHAR(10) + 
	'	Public Class ' + @TableName + CHAR(13) + CHAR(10) + 
	'			Inherits SolomonDataObject' + CHAR(13) + CHAR(10)  
	DECLARE @ColumnName varchar(20), @VBDataType varchar(15), @FieldLen smallint, @FieldIndex smallint
	DECLARE CSR_FieldList CURSOR FOR 
 			SELECT convert(varchar(20), sc.name), VBDataType = CASE sc.xtype 
						WHEN 52 THEN 'Short'	-- smallint 
						WHEN 56 THEN 'Integer'  -- int
						WHEN 58 THEN 'Integer'	-- smalldatetime
						WHEN 62 THEN 'Double'	-- float
						WHEN 175 THEN 'String'  -- char
						ELSE 'N/A'
						END,
		sc.length, 
		ROW_NUMBER() OVER(ORDER BY sc.name) - 1 As FieldIndex
		from syscolumns sc
		JOIN sysobjects so ON sc.id = so.id
		WHERE so.name = @TableName
		AND sc.name <> 'tstamp'
		ORDER BY sc.name

		OPEN CSR_FieldList
		FETCH NEXT FROM CSR_FieldList 
			INTO @ColumnName, @VBDataType, @FieldLen, @FieldIndex
		WHILE @@FETCH_STATUS = 0
			BEGIN
			SET @ColumnName = CASE @ColumnName WHEN 'Module' THEN 'Module_Renamed' ELSE @ColumnName END
			--PRINT @ColumnName
			SET @FieldText = '    < _' + CHAR(13) + CHAR(10) + 
			'    DataBinding(PropertyIndex:=' 
				+ convert(varchar(3), @FieldIndex) 
			+  CASE @VBDataType WHEN 'String' THEN ', StringSize:=' + convert(varchar(3), @FieldLen) ELSE '' END 
			+ ') _' + CHAR(13) + CHAR(10) + 
			'    > _' + CHAR(13) + CHAR(10) + 
			'    Public Property ' + @ColumnName + '() As ' + @VBDataType + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) + 
			'        Get' + CHAR(13) + CHAR(10) + 
			'            Return Me.GetPropertyValue("' + @ColumnName + '")' + CHAR(13) + CHAR(10) +
			'        End Get' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) + 
			'        Set(ByVal setval As ' + @VBDataType + ')' + CHAR(13) + CHAR(10) + 
			'            Me.SetPropertyValue("' + @ColumnName + '", setval)' + CHAR(13) + CHAR(10) + 
			'        End Set' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) + 
			'    End Property' + CHAR(13) + CHAR(10)
			PRINT @FieldText			
			FETCH NEXT FROM CSR_FieldList INTO @ColumnName, @VBDataType, @FieldLen, @FieldIndex
			END

		CLOSE CSR_FieldList
		DEALLOCATE CSR_FieldList

		PRINT '	End Class'
		PRINT 'Public b' + @TableName + ' As ' + @TableName + ' = New ' + @TableName + ', n' + @TableName + ' As ' +@TableName + ' = New ' + @TableName
		+ CHAR(13) + CHAR(10) + 'End Module'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[bapGenerateSDOFile] TO [MSDSL]
    AS [dbo];

