 /****** Object:  Stored Procedure dbo.PrimaryIndexColumns    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.PrimaryIndexColumns    Script Date: 4/7/98 12:56:04 PM ******/
---/* Return all of the columns which are in the named index for the named
---    table.  Any change to MAX_SORT_KEYS (define.h) should be matched by
---    a change here. This proc should be created in both the system and applic
---    databases.
---*/
Create Proc  PrimaryIndexColumns @tabname varchar(30), @indexname varchar(30) as
        select indid,index_col(@tabname,indid,1), index_col(@tabname,indid,2),
                     index_col(@tabname,indid,3), index_col(@tabname,indid,4),
                     index_col(@tabname,indid,5), index_col(@tabname,indid,6),
                     index_col(@tabname,indid,7), index_col(@tabname,indid,8)
                     from sysindexes where id = object_id(@tabname) and
                     name = @indexname



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PrimaryIndexColumns] TO [MSDSL]
    AS [dbo];

