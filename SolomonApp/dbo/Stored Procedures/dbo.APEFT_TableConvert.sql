
create procedure APEFT_TableConvert

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
	declare @StrLenDifCnt		integer
	declare @ToCols			varchar(8000)
   	declare @DataTypeDifCnt    	integer
   	declare @OldType           	tinyint
   	declare @OffSetDifCnt		integer
	
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

	-- Get the count of any columns that have had a datatype change
   -- Only for INTS to CHARS!!!
	-- s1 - old table, syscolumns - new table
	-- ints     (tinyint  48, smallint 52, int 56)
   -- char     175
	SELECT      @DataTypeDifCnt = count(*)
	FROM        syscolumns join syscolumns s1
	ON          s1.name = syscolumns.name and
	            s1.id = @OldID
	WHERE       syscolumns.id = @NewID and
	            (s1.xtype = 48 or s1.xtype = 52 or s1.xtype = 56) and
	            syscolumns.xtype = 175
   -- TK Added
	-- Get the count of any columns that have had an offset change
	-- Changed position!
   -- Only for INTS to CHARS!!!
	-- s1 - old table, syscolumns - new table
	-- ints     (tinyint  48, smallint 52, int 56)
   -- char     175
	SELECT      @OffSetDifCnt = count(*)
	FROM        syscolumns join syscolumns s1
	ON          s1.name = syscolumns.name and
	            s1.id = @OldID
	WHERE       syscolumns.id = @NewID and
	            (s1.xoffset <> syscolumns.xoffset)

	--print @NewColCnt
	--print @NewJoinCnt
	--print @OldColCnt
	--print @OldJoinCnt
	--print @StrLenDifCnt
	--print @DataTypeDifCnt
	--print @OffSetDifCnt

	-- If the count of the columns in one table is equal to the count of columns when compared to the other
	-- table and no char or varchar columns have length differences then the table schema is the same and
	-- doesn't need conversion
 	if @NewColCnt = @NewJoinCnt and
 	   @OldColCnt = @OldJoinCnt and
 	   @NewColCnt = @OldColCnt and
 	   @StrLenDifCnt = 0 and
 	   @DataTypeDifCnt = 0 and
 	   @OffSetDifCnt = 0
 	   begin
         exec ('drop table ' + @NewTable)
		   return
	   end

	-- See if there is an identity column in the new table
	select @IdentityColExists = count(*) from syscolumns
	where id = @NewID and status = 128

	-- Initialize the column accumulators
	select @ToCols = ''
	select @FrCols = ''
	
	-- Select all the columns and column types from the NEW TABLE that are not timestamp datatypes
	declare WorkCursor cursor 
	for 
	select name, xtype 
	from syscolumns 
	where id = @NewID and xtype <> 189
	
	open WorkCursor
	
	fetch next from WorkCursor into 
	@ColName, 
	@ColType

	while (@@fetch_status = 0)
      	begin

			-- Accumulate a list of the all the columns in the new table that will be inserted to
			select @ToCols = @ToCols + ',' + @ColName

			-- See if the column in the new table is also in the old table
			select @Count = Count(*) from syscolumns
			where id = @OldID and name = @ColName and xtype = @ColType

			-- The new table column is also in the old table
			if @Count = 1
			   begin
	         -- Add the column name to the list of columns in the old table that will be the selected from

				select @FrCols = @FrCols + ',' + @ColName
			   end
			else
			   begin
				-- The new table column is not in the old table so we need to initialize the column
				-- according to its datatype
	         		-- OR the datatype has changed
				-- If the new table column is a string type, char or varchar
				if @ColType = 175 or @ColType = 167
				begin

					-- reset to blank value in case column not found
					select @OldType = ''
				
					-- was old col an int (tinying, smallint, int)?
					select @OldType = xtype from syscolumns
		            		where id = @OldID and name = @ColName

					-- if old col was int, then CAST to a char
					if @OldType = 48 or @OldType = 52 or @OldType = 56
		               			begin
				
					      -- Add the initialization string to the select list
				      		select @FrCols = @FrCols + ', Cast(' + @ColName + ' As char)'
					      
		               			end
				      	else
				      		-- otherwise new column was not in old table - add init string
					      	begin
				
						-- Add the initialization string to the select list
						select @FrCols = @FrCols + ','''''

						end
					
				end

				else
				
				begin
					  -- If the column is a date type, datetime or smalldatetime
					  if @ColType = 61 or @ColType = 58
					     begin
	                 -- Add the initialization string to the select list
						select @FrCols = @FrCols + ',''01/01/1900'''
					     end
					  else
					     begin
	                 -- Assume any other datatypes are numeric
						select @FrCols = @FrCols + ',''0'''
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
	select @FrCols + ' from ' + @OldTable
	**/
	
	-- Truncate the new table first
	exec ('truncate table ' + @NewTable)

	-- Set the indentity insert if there are any identity fields in the new table
	if @IdentityColExists > 0 
		begin

		-- Execute the insert statement that will copy all the data from the old table
		exec ('set identity_insert ' + @NewTable + ' on ' +
			'Insert into ' + @NewTable + '(' + @ToCols + ') ' +
			'Select ' + @FrCols + ' from ' + @OldTable + ' ' +
			'set identity_insert ' + @NewTable + ' off')
		end
	else 
		begin

		-- Execute the insert statement that will copy all the data from the old table
		exec ('Insert into '  + @NewTable + '(' + @ToCols + ') ' +
			'Select ' + @FrCols + ' from ' + @OldTable)
		end

	-- Derive the name for old table when it is renamed
	select @OldTableRename = 'APEFTOld' + substring(@OldTable,1,24)

	-- Delete any prior renamed old table if it exists
	if exists(select name from sysobjects where type = 'U' and name = @OldTableRename) begin
		exec ('drop table ' + @OldTableRename)
	end

	-- Rename the passed old table with the old table rename
	exec ('sp_rename ' + @OldTable + ', ' + @OldTableRename)

	-- Rename the passed new table to the passed old table name
	exec ('sp_rename ' + @NewTable + ', ' + @OldTable)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.
