 Create Proc DMG_DEFINE_TABLE_DEFAULTS
	@TABLENAME	VARCHAR(50)
AS
SET NOCOUNT ON
Declare	@SQLCommand	Varchar(255)
If Cursor_Status('Local', 'Constraint_Drop') > 0
Begin
	Close Constraint_Drop
	Deallocate Constraint_Drop
End
Declare Constraint_Drop Cursor Local Scroll For
	Select 	'ALTER TABLE DBO.' + B.NAME + ' DROP CONSTRAINT ' + A.NAME
		From 	sysobjects A JOIN SYSOBJECTS B
			ON A.PARENT_OBJ = B.ID
		Where 	b.name = @TABLENAME
			And A.xtype = 'D'
Open Constraint_Drop
Fetch Next From Constraint_Drop Into @SQLCommand
Print 'Dropping All Constraints For ' + @TableName
Print '--------------------------------------------------------------'
While (@@Fetch_Status = 0)
Begin
	Print @SQLCommand
	Exec (@SQLCommand)
	Fetch Next From Constraint_Drop Into @SQLCommand
End
Close Constraint_Drop
Deallocate Constraint_Drop
Set @SQLCommand = ''
Print ''
If Cursor_Status('Local', 'Constraint_Add') > 0
Begin
	Close Constraint_Add
	Deallocate Constraint_Add
End
Declare Constraint_Add Cursor Local Scroll For
	Select 	'ALTER TABLE DBO.' + o.name + ' With NoCheck ADD CONSTRAINT DF_' + o.name + '_' + C.NAME + ' DEFAULT '
		+	CASE
				WHEN C.XTYPE IN (175,239,99,231,35,167)
					THEN '('' '')'
				WHEN C.XTYPE IN (58,61)
					THEN	Case 	When c.Name Like '%Crtd%'
								Then ' RTRIM(Convert(Varchar(30), Convert(SmallDateTime, GetDate()))) '
							 Else '(''01/01/1900'')'
						End
				WHEN C.XTYPE IN (56,106,62,108,59,52,48,60,122) THEN '(0)'  END
		+ ' FOR ' + c.name
		From 	sysobjects o Join syscolumns c
			On o.id = c.id
			Join systypes t
			On c.xtype = t.xtype
		Where 	o.name = @TABLENAME
			And c.xtype Not In (189)
			And c.colstat <> 1
		Order By o.name, c.colid
Open Constraint_Add
Fetch Next From Constraint_Add Into @SQLCommand
Print 'Adding All Constraints For ' + @TableName
Print '--------------------------------------------------------------'
While (@@Fetch_Status = 0)
Begin
	Print @SQLCommand
	Exec (@SQLCommand)
	Fetch Next From Constraint_Add Into @SQLCommand
End
Close Constraint_Add
Deallocate Constraint_Add

--
-- The following list provides the xtype value for the datatypes covered under the previous cursor
-- XType      DataType
-- 175        Char
-- 239        Nchar
-- 99         Ntext
-- 231        Nvarchar
-- 35         Text
-- 167        Varchar
-- 58         SmallDate
-- 61         DateTime
-- 56         Int
-- 106        Decimal
-- 62         Float
-- 108        Numeric
-- 59         Real
-- 52         SmallInt
-- 48         TinyInt
-- 60         Money
-- 122        SmallMoney


GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_DEFINE_TABLE_DEFAULTS] TO [MSDSL]
    AS [dbo];

