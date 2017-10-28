

create procedure [dbo].[ut_build_index_metadata]
	@tabName sysname		-- the table to check for indexes

	--
	-- Procedure used to build index meta data. Accepts single table nme or wildcard('%') argument to build meta data for all indexes.
	-- To export the data when done, run the following commands(without the quotes), substituting <DBServerName> and <DatabaseName>:
	--  "bcp SLIndex out SLIndex.csv -S<DBServerName> -d<DatabaseName> -T -c -t,"
	--  "bcp SLIndexCol out SLIndexCol.csv -S<DBServerName> -d<DatabaseName> -T -c -t,"
	-- SLIndex.csv and SLIndexCol.csv need to be copied to the appropriate area used by Database Maintenance
	-- 

as

	set nocount on

	declare @tableID int, 			-- the object id of the table
			@indid smallint,	-- the index id of an index
			@tableName sysname,
			@indName sysname,
			@i int,
			@col varchar(128)
		
	
	-- First remove any existing metadata for the given index.
	delete SLIndex where TableName like @tabName
	delete SLIndexCol where TableName like @tabName
	
	-- Insert entries into SLIndex table (skip stats and hypotheticals)
	Insert into SLIndex (TableName, IndexName, IndexID, IsClustered, IsUnique, IsPrimaryKey )
		select o.name, i.name, i.index_id, Case i.Index_ID When 1 then 1 Else 0 END, i.is_unique, i.is_primary_key
		  from sysobjects o
				join sys.indexes i on o.id = i.object_id
				join sys.stats s on i.object_id = s.object_id
					and i.index_id = s.stats_id
		 where o.type = 'U' 
		   and o.name like @tabName  and i.is_hypothetical = 0 and i.index_id !=0

	Insert into SLIndexCol (TableName, IndexName, ColName, ColOrder, IsDescending, IsInclude)
		select  ind.TableName, ind.IndexName, col.name, ic.key_ordinal, ic.is_descending_key, ic.is_included_column
		 from SLIndex Ind join sys.index_columns ic 
							   on object_id(ind.tableName) = ic.object_id 
							  and ind.IndexID = ic.index_id
						  join sys.columns col 
							 on ic.object_id = col.object_id 
							and ic.column_id = col.column_id 
		where Ind.TableName like @tabName 		        
	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[ut_build_index_metadata] TO [MSDSL]
    AS [dbo];

