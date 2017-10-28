

create procedure [dbo].[ut_build_indexes] 
      @tabParm sysname        -- the table to check/rebuild indexes, wildcard ('%') checks all tables
as

      set nocount on

      declare @tableName sysname,
                  @SLindName sysname,
                  @i int,
                  @col varchar(128),
                  @firstInclude bit,
                  @IsInclude bit,
                  @SLindID smallint,
                  @SLisPrimaryKey bit,
                  @DBisPrimaryKey bit,
                  @isUnique bit,
                  @isClustered bit,
                  @isDesc bit,
                  @IndexCols varchar(1000),
                  @CreateStatement varchar(1500)

-- First get all the Clustered Differences, If a clustered index needs built/rebuilt, then all indexes for that table
            -- need rebuilt so handle this case first.
      select distinct Ind.TableName, Ind.IndexName
      into #TempList 
      from SLIndex Ind join sys.tables st
                         on ind.TableName = st.name
                       join SLIndexCol IndCols
                         on Ind.TableName = Indcols.TableName
                        and ind.IndexName = Indcols.IndexName
                        left join 
                      (Select si.object_id, si.name IndexName, Case si.index_id When 1 then 1 else 0 End IsClustered, 
                                 si.is_unique isUnique, si.is_primary_key isPrimaryKey, col.name ColName, ic.key_ordinal ColOrder, ic.is_descending_key IsDescending
                         from sys.indexes si join sys.index_columns ic 
                                                                         on si.object_id = ic.object_id 
                                                                         and si.index_Id = ic.index_id
                                                                join sys.columns col 
                                                                       on ic.object_id = col.object_id 
                                                                       and ic.column_id = col.column_id ) syscolview
                              on object_id(Ind.TableName) = syscolview.object_id
                              and ind.IndexName = syscolview.IndexName
                              and ind.IsClustered = syscolview.IsClustered
                              and ind.IsUnique = syscolview.isUnique
                              and ind.IsPrimaryKey = syscolview.isPrimaryKey
                              and indCols.ColName = syscolview.ColName
                              and indcols.ColOrder = syscolview.ColOrder 
                              and indcols.IsDescending = syscolview.IsDescending
     where ind.TableName like @tabParm
       and ind.isClustered  = 1
         and syscolview.IndexName is null
         
                               
      -- Only one clustered index can exist, so if we are creating a clustered index, need to make sure another clustered index with a
      -- different name doesn't exist.
      insert into #TempList
         select OBJECT_NAME(si.object_id), si.name
           from SLIndex Ind join sys.indexes si
                              on OBJECT_ID(Ind.tablename) = si.object_id
                             and si.index_id = 1
                             and ind.IndexID = 1
                             and ind.IndexName != si.name
                   and TableName in (select distinct TableName from #TempList)

      --Insert the rest of the indexes into the list for any table that the clustered is changing
      insert into #TempList
          select ind.TableName, ind.IndexName
            from SLIndex Ind
           where Ind.IndexID != 1
             and TableName in (select distinct TableName from #TempList)

             
      -- if a primary key exists in the database and it is a different name then the primary key the metadata has for the same table,
      -- that primary key needs to be deleted so the new primary key can be added later.
      insert into #TempList
         select OBJECT_NAME(si.object_id), si.name
           from SLIndex Ind join sys.indexes si
                              on OBJECT_ID(Ind.tablename) = si.object_id
                             and si.is_primary_key = 1
                             and ind.IsPrimaryKey = 1
                             and ind.IndexName != si.name
                             and not exists(select 'x' from #TempList t where object_id(t.TableName) = si.object_id and t.IndexName = si.name)

      -- Loop thru this list dropping all the indexes in the templist that exist, non-clustered indexes should be dropped before the clustered indexes  
      -- since dropping a clustered index rebuilds all non-clustered indexes   
      declare ind_csr cursor local static for
      select  TableName,  IndexName,  si.is_primary_key
        from #TempList t join sys.indexes si on object_id(t.TableName) = si.object_id and t.IndexName = si.name
        order by TableName, si.index_id Desc -- index_id 1 is the descending one 
        
      open ind_csr  
      fetch ind_csr into @tableName, @SLindName,@DBisPrimarykey
      
      while (@@FETCH_STATUS >= 0)
      Begin
            -- debug print 'Dropping ' + @SLindName
          if (@DBisPrimaryKey = 1)
            Begin
                  exec ('Alter table ' + @tablename + ' Drop Constraint ' + @SLIndName)
            End
            Else
            Begin
                  exec('Drop Index ' + @tablename + '.' + @SLIndName)
            End
            fetch ind_csr into @tableName, @SLindName, @DBisPrimarykey
      End
      close ind_csr
      deallocate ind_csr
            
-- Now get all differences and build/rebuild indexes as necessary
-- All clustered indexes that need to be dropped should be dropped by now. On create, Cluster indexes
-- should be created first to avoid unnecessary rebuilds of non-clustered indexes.
      truncate table #TempList      
    insert into #TempList 
    select distinct Ind.TableName, Ind.IndexName
      from SLIndex Ind join sys.tables st
                         on ind.TableName = st.name
                       join SLindexCol IndCols
                         on Ind.TableName = Indcols.TableName
                        and ind.IndexName = Indcols.IndexName
                        left join 
                      (Select si.object_id, si.name IndexName, Case si.index_id When 1 then 1 else 0 End IsClustered, 
                                 si.is_unique isUnique, si.is_primary_key isPrimaryKey, col.name ColName, ic.key_ordinal ColOrder, ic.is_descending_key IsDescending
                         from sys.indexes si join sys.index_columns ic 
                                                                         on si.object_id = ic.object_id 
                                                                         and si.index_Id = ic.index_id
                                                                join sys.columns col 
                                                                       on ic.object_id = col.object_id 
                                                                       and ic.column_id = col.column_id ) syscolview
                              on object_id(Ind.TableName) = syscolview.object_id
                              and ind.IndexName = syscolview.IndexName
                              and ind.IsClustered = syscolview.IsClustered
                              and ind.IsUnique = syscolview.isUnique
                              and ind.IsPrimaryKey = syscolview.isPrimaryKey
                              and indCols.ColName = syscolview.ColName
                              and indcols.ColOrder = syscolview.ColOrder 
                              and indcols.IsDescending = syscolview.IsDescending
     where ind.TableName like @tabParm
         and syscolview.IndexName is null

      -- Loop thru this list building/rebuilding all the indexes in the templist.
      -- rebuild any clustered indexes first since rebuilding clustered index causes non-clustered to rebuild
      declare ind2_csr cursor local static for
      select  SL.TableName,  SL.IndexName, SL.isClustered, SL.IsPrimaryKey, SL.isUnique 
        from #TempList t join SLIndex SL
                           on t.TableName = SL.TableName
                           and t.IndexName = SL.IndexName
                         left join sys.indexes si 
                                on object_id(t.TableName) = si.object_id and t.IndexName = si.name
        order by SL.TableName, SL.isClustered Desc --third col is cluster indicator, 0=non 1=clust 
      
      open ind2_csr  
      
      fetch ind2_csr into @tableName, @SLindName, @isClustered, @SLisPrimaryKey, @isUnique
      while (@@FETCH_STATUS >= 0)
      Begin
            select @DBisPrimaryKey=si.is_primary_key from sys.indexes si where si.object_id = object_id(@tableName) and si.name = @SLindName
            if (@@ROWCOUNT  > 0)
            Begin
                  if (@DBisPrimaryKey = 1)
                  Begin
                        exec ('Alter table ' + @tablename + ' Drop Constraint ' + @SLIndName)
                  End
                  Else
                  Begin
                        exec('Drop Index ' + @tablename + '.' + @SLIndName)
                  End
            End
            
            -- now need to create the index
            -- get the column list first.
            set @IndexCols = ''
            declare indcol_csr cursor local static for
                  select colName, IsDescending, IsInclude from SLIndexCol where TableName = @tableName and IndexName = @SLindName 
                   order by IsInclude, ColOrder
            open indcol_csr
            fetch indcol_csr into @Col, @IsDesc, @IsInclude
            set @firstInclude = 1
            while @@FETCH_STATUS >= 0
            Begin
                  if (@firstInclude = 1 and @isInclude = 1)
                  Begin
                        set @firstInclude = 0
                        set @IndexCols = @IndexCols + ') Include (' + @Col + Case @isDesc When 1 Then ' Desc' else '' End
                  End
                  Else
                  Begin
                        set @IndexCols = @IndexCols + @Col + Case @isDesc When 1 Then ' Desc' else '' End
                  End
                  fetch indcol_csr into @Col, @IsDesc, @IsInclude
                  if (@@FETCH_STATUS >= 0 and (@IsInclude = 0 or @firstInclude = 0) )
                        set @IndexCols = @IndexCols + ','
            END
            close indcol_csr
            deallocate indcol_csr
            Set @CreateStatement = 
                   CASE @SLisPrimaryKey 
                    WHEN 1 THEN 'ALTER TABLE ' + @tableName+' ADD CONSTRAINT '+@SLIndName+' PRIMARY KEY'+ 
                           (CASE @isClustered WHEN 1 THEN ' CLUSTERED' ELSE ' NONCLUSTERED ' END) 
                    ELSE 'CREATE '+ 
                            (CASE @isUnique WHEN 1  THEN 'UNIQUE ' ELSE '' END)+ 
                            (CASE @isClustered WHEN 1 THEN 'CLUSTERED ' ELSE ' NONCLUSTERED ' END)+ 
                          'INDEX '+@SLIndName+' ON '+@TableName 
                    END+ ' ('+ @indexCols + ')'
            exec (@CreateStatement)
            fetch ind2_csr into @tableName, @SLindName, @isClustered, @SLisPrimaryKey, @isUnique
      End
      close ind2_csr
      deallocate ind2_csr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[ut_build_indexes] TO [MSDSL]
    AS [dbo];

