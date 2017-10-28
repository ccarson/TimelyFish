 create proc ut_dbcomp_col @db1name char(40),@db2name char(40),@tabname Char(40)
as
/********************************************************************************
*            Copyright Solomon Software, Inc. 1994-1998 All Rights Reserved
** Proc Name     : ut_dbcomp_col
** Narrative     : Creates a output listing of differences of two versions of a table.
** Inputs        : db1name     first database to compare, must be on current server
*                 db2name     second database to compare, must be on current server
*                 tabname     table to compare
** Outputs       : Listing of differences between columns of tables given
** Called by     : ut_dbcomp
*
********************************************************************************
* #  Init  Date     Change
********************************************************************************
*001  CLS   08/25/98  Initial Creation
*********************************************************************************
*/
declare @db1col   char     (40)
declare @db1len   int
declare @db1prec  int
declare @db1type  char     (11)

declare @db2col   char     (40)
declare @db2len   int
declare @db2prec  int
declare @db2type  char     (11)

declare @holdcol1 char     (40)
declare @holdcol2 char     (40)
declare @prtspc   char     (40)
declare @pointer  char     (2)
declare @diff   char       (1)
declare @fet1     int
declare @fet2     int

select @prtspc = ' ',
       @diff='N',
       @pointer = ' '

/*************************************/
/* Set up cursor for first data base */
/*************************************/
exec ("declare db1csrcol cursor for select substring(sc.name,1,40),substring(st.name,1,10),
                                           sc.length,sc.prec from "+ @db1name + "..syscolumns sc, "+
                                             @db1name + "..sysobjects so, "+ @db1name + "..systypes st where so.id = sc.id and so.name ='"+@tabname+
                                             "' and st.usertype = sc.usertype order by sc.name")
open db1csrcol
fetch db1csrcol into @db1col,@db1type,@db1len,@db1prec
select @fet1 = @@fetch_status

/*************************************/
/* Set up cursor for second data base */
/*************************************/
exec ("declare db2csrcol cursor for select substring(sc.name,1,40),substring(st.name,1,10),
                                           sc.length,sc.prec from "+ @db2name + "..syscolumns sc, "+
                                           @db2name + "..sysobjects so, "+@db2name + "..systypes st  where so.id = sc.id and so.name ='"+@tabname+
                                             "' and st.usertype = sc.usertype order by sc.name")
open db2csrcol
fetch db2csrcol into @db2col,@db2type,@db2len,@db2prec
select @fet2 = @@fetch_status

/***********************/
/* Start Column Compare */
/***********************/

While @fet1 = 0 or @fet2 = 0
begin
  if @fet1 = 0
  begin
    select @holdcol1 = @db1col
  end
  else
    begin
    select @holdcol1='zzzzzzzzzzzzzzzzzzz'
    end

  if @fet2 = 0
  begin
    select @holdcol2 = @db2col
  end
  else
    begin
    select @holdcol2='zzzzzzzzzzzzzzzzzzz'
    end
  /*debug  select 'db1col=',@db1col,'db2col=',@db2col*/

  if @fet1 <> 0 or @holdcol1 > @holdcol2
  begin
      --select @pointer = '>>'
      if @diff = 'N'
      begin
         select @diff = 'Y'
         select @tabname,'<>',@tabname
      end
      select @prtspc,@pointer,'--' + substring(@db2col,1,17) +@db2type + convert(char(5),@db2len) + convert(char(5),@db2prec)
  end
  else
  if @fet2 <> 0 or @holdcol2 > @holdcol1
  begin
      --select @pointer = '<<'
      if @diff = 'N'
      begin
         select @diff = 'Y'
         select @tabname,'<>',@tabname
      end
      select '--' + substring(@db1col,1,17) +@db1type + convert(char(5),@db1len) + convert(char(5),@db1prec),@pointer,@prtspc
  end
  else
  begin
      if  @db1type <> @db2type or @db1len <> @db2len or @db1prec <> @db2prec
      begin
        if @diff = 'N'
        begin
          select @diff = 'Y'
          select @tabname,'<>',@tabname
        end
        select '--' + substring(@db1col,1,17) +@db1type + convert(char(5),@db1len) + convert(char(5),@db1prec),
               @pointer,
               '--' + substring(@db2col,1,17) +@db2type + convert(char(5),@db2len) + convert(char(5),@db2prec)
      end
  end

  /**********************/
  /* Get next record(s) */
  /**********************/

  if @fet1 = 0 and @holdcol1 <= @holdcol2
  begin
     fetch db1csrcol into @db1col,@db1type,@db1len,@db1prec
     select @fet1 = @@fetch_status
  /*        select 'here1',@db1col,convert(char(5),@fet1)*/
     if @fet1 <> 0
       select @db1col = ' '
  end

  if @fet2 = 0  and @holdcol2 <= @holdcol1
  begin

     fetch db2csrcol into @db2col,@db2type,@db2len,@db2prec
     select @fet2 = @@fetch_status
 /*debug         select 'here2',@db2col,convert(char(5),@fet2)*/
      if @fet2 <> 0
       select @db2col = ' '
  end

end

/* Clean up cursors */

close db1csrcol
deallocate db1csrcol
close db2csrcol
deallocate db2csrcol



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ut_dbcomp_col] TO [MSDSL]
    AS [dbo];

