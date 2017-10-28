
CREATE procedure [cfp_columns]
(
    @table_name         nvarchar(384),
    @fieldlist_cursor CURSOR VARYING OUTPUT,
    @table_owner        nvarchar(384) = null,
    @table_qualifier    sysname = null,
    @column_name        nvarchar(384) = null,
    @ODBCVer            int = 2
)
as
    declare @full_table_name    nvarchar(769) -- 384 + 1 + 384
    declare @table_id           int
    declare @fUsePattern        bit

    select @fUsePattern = 1

    if (@ODBCVer is null) or (@ODBCVer <> 3)
        select @ODBCVer = 2

    if @table_qualifier is not null
    begin
        if db_name() <> @table_qualifier
        begin   -- If qualifier doesn't match current database
            raiserror (15250, -1,-1)
            return
        end
    end

    -- "ALL" is represented by NULL value.
    if @table_name = '%'
        select @table_name = null
    if @table_owner = '%'
        select @table_owner = null
    if @table_qualifier = '%'
        select @table_qualifier = null
    if @column_name = '%'
        select @column_name = null

    -- Empty string means nothing, so use invalid identifier.
    -- A quoted space will never match any object name.
    if @table_owner = ''
        select @table_owner = ' '

    select @full_table_name = isnull(quotename(@table_owner), '') + '.' + isnull(quotename(@table_name), '')
    select @table_id = object_id(@full_table_name)

    if (@fUsePattern = 1) -- Does the user want it?
    begin
        if ((isnull(charindex('%', @full_table_name),0) = 0) and
            (isnull(charindex('_', @full_table_name),0) = 0) and
            (isnull(charindex('[', @table_name),0) = 0) and
            (isnull(charindex('[', @table_owner),0) = 0) and
            (isnull(charindex('%', @column_name),0) = 0) and
            (isnull(charindex('_', @column_name),0) = 0) and
            (@table_id <> 0))
        begin
            select @fUsePattern = 0 -- not a single wild char, so go the fast way.
        end
    end

    if @fUsePattern = 0
    begin
        /* -- Debug output, do not remove it.
        print '*************'
        print 'No pattern matching.'
        print @fUsePattern
        print isnull(convert(sysname, @table_id), '@table_id = null')
        print isnull(@full_table_name, '@full_table_name = null')
        print isnull(@table_owner, '@table_owner = null')
        print isnull(@table_name, '@table_name = null')
        print isnull(@column_name, '@column_name = null')
        print '*************'
        */
        select
            TABLE_QUALIFIER             = s_cov.TABLE_QUALIFIER,
            TABLE_OWNER                 = s_cov.TABLE_OWNER,
            TABLE_NAME                  = s_cov.TABLE_NAME,
            COLUMN_NAME                 = s_cov.COLUMN_NAME,
            DATA_TYPE                   = s_cov.DATA_TYPE_28,
            TYPE_NAME                   = s_cov.TYPE_NAME_28,
            "PRECISION"                 = s_cov.PRECISION_28,
            "LENGTH"                    = s_cov.LENGTH_28,
            SCALE                       = s_cov.SCALE_90,
            RADIX                       = s_cov.RADIX,
            NULLABLE                    = s_cov.NULLABLE,
            REMARKS                     = s_cov.REMARKS,
            COLUMN_DEF                  = s_cov.COLUMN_DEF,
            SQL_DATA_TYPE               = s_cov.SQL_DATA_TYPE_28,
            SQL_DATETIME_SUB            = s_cov.SQL_DATETIME_SUB_90,
            CHAR_OCTET_LENGTH           = s_cov.CHAR_OCTET_LENGTH_28,
            ORDINAL_POSITION            = s_cov.ORDINAL_POSITION,
            IS_NULLABLE                 = s_cov.IS_NULLABLE,
            SS_DATA_TYPE                = s_cov.SS_DATA_TYPE

        from
            sys.spt_columns_odbc_view s_cov

        where
            s_cov.object_id = @table_id -- (2nd) (@table_name is null or o.name like @table_name)
            -- (2nd) and (@table_owner is null or schema_name(o.schema_id) like @table_owner)
            and (@column_name is null or s_cov.COLUMN_NAME = @column_name) -- (2nd)             and (@column_name is NULL or c.name like @column_name)
            and s_cov.ODBCVER = @ODBCVer
            and s_cov.OBJECT_TYPE <> 'TT'
            and ( s_cov.SS_IS_SPARSE = 0 OR objectproperty ( s_cov.OBJECT_ID, 'tablehascolumnset' ) = 0 )
        order by 17
    end
    else
    begin
        /* -- Debug output, do not remove it.
        print '*************'
        print 'THERE IS pattern matching!'
        print @fUsePattern
        print isnull(convert(sysname, @table_id), '@table_id = null')
        print isnull(@full_table_name, '@full_table_name = null')
        print isnull(@table_owner, '@table_owner = null')
        print isnull(@table_name, '@table_name = null')
        print isnull(@column_name, '@column_name = null')
        print '*************'
    */
        select
            TABLE_QUALIFIER             = s_cov.TABLE_QUALIFIER,
            TABLE_OWNER                 = s_cov.TABLE_OWNER,
            TABLE_NAME                  = s_cov.TABLE_NAME,
            COLUMN_NAME                 = s_cov.COLUMN_NAME,
            DATA_TYPE                   = s_cov.DATA_TYPE_28,
            TYPE_NAME                   = s_cov.TYPE_NAME_28,
            "PRECISION"                 = s_cov.PRECISION_28,
            "LENGTH"                    = s_cov.LENGTH_28,
            SCALE                       = s_cov.SCALE_90,
            RADIX                       = s_cov.RADIX,
            NULLABLE                    = s_cov.NULLABLE,
            REMARKS                     = s_cov.REMARKS,
            COLUMN_DEF                  = s_cov.COLUMN_DEF,
            SQL_DATA_TYPE               = s_cov.SQL_DATA_TYPE_28,
            SQL_DATETIME_SUB            = s_cov.SQL_DATETIME_SUB_90,
            CHAR_OCTET_LENGTH           = s_cov.CHAR_OCTET_LENGTH_28,
            ORDINAL_POSITION            = s_cov.ORDINAL_POSITION,
            IS_NULLABLE                 = s_cov.IS_NULLABLE,
            SS_DATA_TYPE                = s_cov.SS_DATA_TYPE

        from
            sys.spt_columns_odbc_view s_cov

        where
            s_cov.ODBCVER = @ODBCVer and
            s_cov.OBJECT_TYPE <> 'TT' and
            (@table_name is null or s_cov.TABLE_NAME like @table_name) and
            (@table_owner is null or schema_name(s_cov.SCHEMA_ID) like @table_owner) and
            (@column_name is null or s_cov.COLUMN_NAME like @column_name) and
            ( s_cov.SS_IS_SPARSE = 0 OR objectproperty ( s_cov.OBJECT_ID, 'tablehascolumnset' ) = 0 )

        order by 2, 3, 17
    end
