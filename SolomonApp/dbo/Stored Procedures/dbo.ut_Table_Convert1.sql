
create procedure ut_Table_Convert1

        @OldTable varchar(30),
        @NewTable varchar(30)
as
        declare @ColName                varchar(30)
        declare @ColType                tinyint
        declare @Count                  integer
        declare @FrCols                 varchar(255)
        declare @FrCols1                varchar(255)
        declare @FrCols2                varchar(255)
        declare @FrCols3                varchar(255)
        declare @FrCols4                varchar(255)
        declare @FrCols5                varchar(255)
        declare @FrCols6                varchar(255)
        declare @FrCols7                varchar(255)
        declare @FrCols8                varchar(255)
        declare @FrCols9                varchar(255)
        declare @FrCols10               varchar(255)
        declare @FrColsCnt              smallint
        declare @IdentityColExists      smallint
        declare @NewID                  integer
        declare @OldID                  integer
        declare @OldTableRename         varchar(30)
        declare @ToCols                 varchar(255)
        declare @ToCols1                varchar(255)
        declare @ToCols2                varchar(255)
        declare @ToCols3                varchar(255)
        declare @ToCols4                varchar(255)
        declare @ToCols5                varchar(255)
        declare @ToCols6                varchar(255)
        declare @ToCols7                varchar(255)
        declare @ToCols8                varchar(255)
        declare @ToCols9                varchar(255)
        declare @ToCols10               varchar(255)
        declare @ToColsCnt              smallint

        -- Get the table id of the new table
        select @NewID = id from sysobjects
        where name = @NewTable

        -- if the new table does not exist, just skip it
        if @NewID is NULL begin
                return
        end

        -- Get the table id if the old table
        select @OldID = id from sysobjects
        where name = @OldTable

        -- If the old table does not exist, just rename the new table
        if @OldID is NULL begin

                exec ("sp_rename " + @NewTable + ", " + @OldTable)
                return
        end

        -- See if there is an identity column in the new table
        select @IdentityColExists = count(*) from syscolumns
        where id = @NewID and status = 128

        -- Initialize the column accumulators
        select @ToCols = ''
        select @FrCols = ''

        -- Initialize the column variable counters
        select @ToColsCnt = 1
        select @FrColsCnt = 1

        -- Select all the columns and column types from the new table that are not timestamp datatypes
        declare WorkCursor cursor for select name, type from syscolumns
        where id = @NewID and (type <> 45 or (type = 45 and usertype <> 80))
        open WorkCursor
        fetch next from WorkCursor into @ColName, @ColType

        while (@@fetch_status = 0) begin

                -- Accumulate a list of the all the columns in the new table that will be inserted to
                select @ToCols = @ToCols + "," + @ColName

                -- See if the column in the new table is also in the old table
                select @Count = Count(*) from syscolumns
                where id = @OldID and name = @ColName and type = @ColType

                -- The new table column is also in the old table
                if @Count = 1 begin

                        -- Add the column name to the list of columns in the old table that will be the selected from
                        select @FrCols = @FrCols + "," + @ColName
                end
                else begin
                        -- The new table column is not in the old table so we need to initialize the column
                        -- according to its datatype
                        -- If the column is a string type, char or varchar
                        if @ColType = 47 or @ColType = 39 begin

                                -- Add the initialization string to the select list
                                select @FrCols = @FrCols + ",''"
                        end
                        else begin
                                -- If the column is a date type, datetime, datatimn or smalldatetime
                                if @ColType = 61 or @ColType = 111 or @ColType = 58 begin

                                        -- Add the initialization string to the select list
                                        select @FrCols = @FrCols + ",'01/01/1900'"
                                end
                                else begin

                                        -- Assume any other datatypes are numeric
                                        select @FrCols = @FrCols + ",0"
                                end
                        end
                end

                -- If the accumulated column list is nearing the maximum length of a variable
                -- then store the column list in another variable and continue on
                if datalength(@ToCols) > 220 begin

                        -- Store up to 10 variables of column lists, keep track of how many we have done
                        -- with the @ToColsCnt variable

                        if @ToColsCnt = 1 begin
                                select @ToCols1 = @ToCols
                        end

                        if @ToColsCnt = 2 begin
                                select @ToCols2 = @ToCols
                        end

                        if @ToColsCnt = 3 begin
                                select @ToCols3 = @ToCols
                        end

                        if @ToColsCnt = 4 begin
                                select @ToCols4 = @ToCols
                        end

                        if @ToColsCnt = 5 begin
                                select @ToCols5 = @ToCols
                        end

                        if @ToColsCnt = 6 begin
                                select @ToCols6 = @ToCols
                        end

                        if @ToColsCnt = 7 begin
                                select @ToCols7 = @ToCols
                        end

                        if @ToColsCnt = 8 begin
                                select @ToCols8 = @ToCols
                        end

                        if @ToColsCnt = 9 begin
                                select @ToCols9 = @ToCols
                        end

                        if @ToColsCnt = 10 begin
                                select @ToCols10 = @ToCols
                        end

                        select @ToCols = ""
                        select @ToColsCnt = @ToColsCnt + 1
                end

                -- If the accumulated column list is nearing the maximum length of a variable
                -- then store the column list in another variable and continue on
                if datalength(@FrCols) > 220 begin

                        -- Store up to 10 variables of column lists, keep track of how many we have done
                        -- with the @FrColsCnt variable

                        if @FrColsCnt = 1 begin
                                select @FrCols1 = @FrCols
                        end

                        if @FrColsCnt = 2 begin
                                select @FrCols2 = @FrCols
                        end

                        if @FrColsCnt = 3 begin
                                select @FrCols3 = @FrCols
                        end

                        if @FrColsCnt = 4 begin
                                select @FrCols4 = @FrCols
                        end

                        if @FrColsCnt = 5 begin
                                select @FrCols5 = @FrCols
                        end

                        if @FrColsCnt = 6 begin
                                select @FrCols6 = @FrCols
                        end

                        if @FrColsCnt = 7 begin
                                select @FrCols7 = @FrCols
                        end

                        if @FrColsCnt = 8 begin
                                select @FrCols8 = @FrCols
                        end

                        if @FrColsCnt = 9 begin
                                select @FrCols9 = @FrCols
                        end

                        if @FrColsCnt = 10 begin
                                select @FrCols10 = @FrCols
                        end

                        select @FrCols = ""
                        select @FrColsCnt = @FrColsCnt + 1
                end

                fetch next from WorkCursor into @ColName, @ColType
        end

        close WorkCursor

        deallocate WorkCursor

        if @ToCols1 is NULL begin

                -- If @ToCols1 is NULL, then the whole clause is in the @ToCols variable
                -- so strip off the leading comma from it
                select @ToCols = substring(ltrim(@ToCols), 2, datalength(ltrim(@ToCols)))
        end
        else begin
                -- Otherwise strip the comma off the @ToCols1 variable
                select @ToCols1 = substring(ltrim(@ToCols1), 2, datalength(ltrim(@ToCols1)))
        end

        if @FrCols1 is NULL begin

                -- If @FrCols1 is NULL, then the whole clause is in the @FrCols variable
                -- so strip off the leading comma from it
                select @FrCols = substring(ltrim(@FrCols), 2, datalength(ltrim(@FrCols)))
        end
        else begin
                -- Otherwise strip the comma off the @FrCols1 variable
                select @FrCols1 = substring(ltrim(@FrCols1), 2, datalength(ltrim(@FrCols1)))
        end

        -- Uncomment this to see what the sql statement is
 select "Insert into " + @NewTable + "("
        select @ToCols1
        select @ToCols2
        select @ToCols3
        select @ToCols4
        select @ToCols5
        select @ToCols6
        select @ToCols7
        select @ToCols8
        select @ToCols9
        select @ToCols10
        select @ToCols +  ")"
        select "Select "
        select @FrCols1
        select @FrCols2
        select @FrCols3
        select @FrCols4
        select @FrCols5
        select @FrCols6
        select @FrCols7
        select @FrCols8
        select @FrCols9
        select @FrCols10
        select @FrCols + " from " + @OldTable

        -- Truncate the new table first
        exec ("truncate table " + @NewTable)

        -- Set the indentity insert if there are any identity fields in the new table
        if @IdentityColExists > 0 begin

                -- Execute the insert statement that will copy all the data from the old table
                exec ("set identity_insert " + @NewTable + " on " +
                        "Insert into " + @NewTable + "(" +
                        @ToCols1 + @ToCols2 + @ToCols3 + @ToCols4 + @ToCols5 +
                        @ToCols6 + @ToCols7 + @ToCols8 + @ToCols9 + @ToCols10 + @ToCols +  ") " +
                        "Select " + @FrCols1 + @FrCols2 + @FrCols3 + @FrCols4 + @FrCols5 +
                        @FrCols6 + @FrCols7 + @FrCols8 + @FrCols9 + @FrCols10 + @FrCols  + " from " + @OldTable + " " +
                        "set identity_insert " + @NewTable + " off")
        end
        else begin

                -- Execute the insert statement that will copy all the data from the old table
                exec ("Insert into " + @NewTable + "(" +
                        @ToCols1 + @ToCols2 + @ToCols3 + @ToCols4 + @ToCols5 +
                        @ToCols6 + @ToCols7 + @ToCols8 + @ToCols9 + @ToCols10 + @ToCols +  ") " +
                        "Select " + @FrCols1 + @FrCols2 + @FrCols3 + @FrCols4 + @FrCols5 +
                        @FrCols6 + @FrCols7 + @FrCols8 + @FrCols9 + @FrCols10 + @FrCols  + " from " + @OldTable)
        end
      IF @@ERROR <>  0
      BEGIN
         PRINT 'INSERT FAILED'
         GOTO FINISH
      END
        -- Drop the passed old table with the old table rename
        exec ("drop table " + @OldTable)
      IF @@ERROR <>  0
      BEGIN
         PRINT 'DROP OF OLD TABLE FAILED'
         GOTO FINISH
      END


FINISH:


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ut_Table_Convert1] TO [MSDSL]
    AS [dbo];

