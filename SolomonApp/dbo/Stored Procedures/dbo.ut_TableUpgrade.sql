 create procedure ut_TableUpgrade

	@OldTable varchar(30),
	@NewTable varchar(30)
as
	declare @ColName		varchar(30)
	declare @ColType		tinyint
	declare @Count			integer
	declare @FrCols			varchar(8000)
	declare @IdentityColExists	smallint
	declare @NewColCnt		integer
	declare @NewJoinCnt		integer
	declare @NewID			integer
	declare @OldColCnt		integer
	declare @OldJoinCnt		integer
	declare @OldID			integer
	declare @OldTableRename		varchar(30)
	declare @OrderChangeCnt		integer
	declare @StrLenDifCnt		integer
	declare @TypeChangeCnt		integer
	declare @ToCols			varchar(8000)

	-- Get the table id of the new table
	select @NewID = id from sysobjects
	where name = @NewTable

	-- if the new table does not exist, just skip it
	if @NewID is NULL begin
		return
 	end

	-- Get the table id of the old table
	select @OldID = id from sysobjects
	where name = @OldTable

	-- If the old table does not exist, just rename the new table
	if @OldID is NULL begin

		exec ('sp_rename ' + @NewTable + ', ' + @OldTable)
		return
	end

	-- Get the count of the columns in the new table
	select @NewColCnt = count(*) from syscolumns
	where id = @NewID

	-- Get the count of the columns in the old table
	select @OldColCnt = count(*) from syscolumns
	where id = @OldID

	-- Get the count of columns in the new table that are also in the old table
	select @NewJoinCnt = count(*) from syscolumns
	where syscolumns.id = @NewID and name in (select name from syscolumns where id = @OldID)

	-- Get the count of columns in the old table that are also in the new table
	select @OldJoinCnt = count(*) from syscolumns
	where syscolumns.id = @OldID and name in (select name from syscolumns where id = @NewID)

	-- Get the count of any char or varchar columns that have had a length change
	select @StrLenDifCnt = count(*) from syscolumns
	join syscolumns s1 on s1.name = syscolumns.name and s1.id = @OldID
	where syscolumns.id = @NewID and (syscolumns.xtype = 175 or syscolumns.xtype = 167) and syscolumns.length <> s1.length

	-- Get the count of any columns in the old and new table that have different column ids. This means
	-- the columns are in a different order and the table should be converted.
	select @OrderChangeCnt = count(*) from syscolumns s1
	join syscolumns s2 on s1.name = s2.name
	where s1.id = @NewID and s2.id = @OldID and s1.colid <> s2.colid

	-- Get the count of any columns in the old and new table that have different types. This means
	-- the table should be converted. This will cause conversion errors depending on what the
	-- from and to types are but hopefully this will be caught in testing.
	select @TypeChangeCnt = count(*) from syscolumns s1
	join syscolumns s2 on s1.name = s2.name
	where s1.id = @NewID and s2.id = @OldID and s1.xtype <> s2.xtype

	--print @NewColCnt
	--print @NewJoinCnt
	--print @OldColCnt
	--print @OldJoinCnt
	--print @StrLenDifCnt
	--print @OrderChangeCnt
	--print @TypeChangeCnt

	-- If the count of columns in each table is the same as the count of the columns it has in common with
	-- the other table and no char or varchar columns have length differences and the order of the columns has not changed
	-- and the types of matching columns have not changed then the table schema is the same and doesn't need conversion
	if @NewColCnt = @NewJoinCnt and @OldColCnt = @OldJoinCnt and @NewColCnt = @OldColCnt and @StrLenDifCnt = 0 and @OrderChangeCnt = 0 and @TypeChangeCnt = 0 begin

		exec ('drop table ' + @NewTable)
		return
	end
		-- See if there is an identity column in the new table
	select @IdentityColExists = count(*) from syscolumns
	where id = @NewID and status = 128

	-- Initialize the column accumulators
	select @ToCols = ''
	select @FrCols = ''

	-- Select all the columns and column types from the new table that are not timestamp datatypes
	declare WorkCursor cursor for select name, xtype from syscolumns where id = @NewID and xtype <> 189
	open WorkCursor
	fetch next from WorkCursor into @ColName, @ColType
		while (@@fetch_status = 0) begin

		-- Accumulate a list of the all the columns in the new table that will be inserted to
		select @ToCols = @ToCols + ',' + @ColName

		-- See if the column in the new table is also in the old table
		-- This will only convert columns that have the same type or are smallints being converted to ints
		-- Other cases should be added here as needed
		select @Count = Count(*) from syscolumns
		where id = @OldID and name = @ColName and (xtype = @ColType or (xtype = 52 and @ColType = 56))

		-- The new table column is also in the old table
		if @Count = 1 begin

			-- Add the column name to the list of columns in the old table that will be the selected from
			select @FrCols = @FrCols + ',' + @ColName
		end
		else begin
			-- The new table column is not in the old table so we need to initialize the column
			-- according to its datatype
			-- If the column is a string type, char or varchar
			if @ColType = 175 or @ColType = 167 begin

				-- Add the initialization string to the select list
				select @FrCols = @FrCols + ','''''
			end
			else begin
				-- If the column is a date type, datetime or smalldatetime
				if @ColType = 61 or @ColType = 58 begin

					-- Add the initialization string to the select list
					select @FrCols = @FrCols + ',''01/01/1900'''
				end
				else begin

					-- Assume any other datatypes are numeric
					select @FrCols = @FrCols + ',0'
				end
			end
		end

		fetch next from WorkCursor into @ColName, @ColType
	end

	close WorkCursor

	deallocate WorkCursor

	-- Strip off the leading comma
	select @ToCols = substring(ltrim(@ToCols), 2, datalength(ltrim(@ToCols)))

	-- Strip off the leading comma
	select @FrCols = substring(ltrim(@FrCols), 2, datalength(ltrim(@FrCols)))

	-- Uncomment this to see what the sql statement is
	/** select 'Insert into ' + @NewTable + '('
	select @ToCols +  ')'
	select 'Select '
	select @FrCols + ' from ' + @OldTable **/

	-- Truncate the new table first
	exec ('truncate table ' + @NewTable)

	-- Set the indentity insert if there are any identity fields in the new table
	if @IdentityColExists > 0 begin

		-- Execute the insert statement that will copy all the data from the old table
		exec ('set identity_insert ' + @NewTable + ' on ' +
			'Insert into ' + @NewTable + '(' + @ToCols +  ') ' +
			'Select ' + @FrCols  + ' from ' + @OldTable + ' ' +
			'set identity_insert ' + @NewTable + ' off')
	end
	else begin
			-- Execute the insert statement that will copy all the data from the old table
		exec ('Insert into ' + @NewTable + '(' + @ToCols +  ') ' +
			'Select ' + @FrCols  + ' from ' + @OldTable)
	end

        IF @@ERROR <>  0
        BEGIN
            PRINT 'INSERT FAILED'
            GOTO FINISH
        END

        -- Drop the passed old table with the old table rename
        exec ('drop table ' + @OldTable)
        IF @@ERROR <>  0
        BEGIN
           PRINT 'DROP OF OLD TABLE FAILED'
           GOTO FINISH
        END

        -- Rename the passed new table to the passed old table name
        exec ('sp_rename ' + @NewTable + ', ' + @OldTable)
        IF @@ERROR <>  0
        BEGIN
           PRINT 'RENAME NEW to OLD NAME FAILED'
           PRINT ' '
           PRINT '!!!! RECOVER OLD TABLE FROM NEW TABLE BEFORE RERUNNING !!!!!'
           PRINT '!!!! OR RENAME NEW TABLE BY HAND TO FINISH'
           GOTO FINISH
        END

FINISH:


