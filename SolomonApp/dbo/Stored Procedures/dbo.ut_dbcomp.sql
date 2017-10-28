 create proc ut_dbcomp @db1name char(40),@db2name char(40),@tabname Char(40)
as
/********************************************************************************
*            Copyright Solomon Software, Inc. 1994-1998 All Rights Reserved
** Proc Name     : ut_dbcomp
** Narrative     : Creates a listing of table differences between two databases
** Inputs        : db1name     first database to compare, must be on current server
*                 db2name     second database to compare, must be on current server
*                 tabname     table to compare, accepts wildcards.
** Outputs       : Listing of differences between tables of databases given
** Called by     : isql/w, standalone program
*
********************************************************************************
* #  Init  Date     Change
********************************************************************************
*001  CLS   08/25/98  Initial Creation
*********************************************************************************
*/
declare @holdstmt varchar (255)
declare @db1tab   char     (40)
declare @db2tab   char     (40)
declare @holdtab1 char     (40)
declare @holdtab2 char     (40)
declare @prtspc   char     (40)
declare @pointer  char     (2)
declare @nodiff   char     (1)
declare @fet1     int
declare @fet2     int

select @prtspc =' '

/***********************/
/* Set up header lines */
/***********************/
Select '            D A T A B A S E     D I F F E R E N C E S '
select ' '
select ' '
select @db1name, '  ',@db2name

select '---------------------------------------- -- ----------------------------------------'
/*************************************/
/* Set up cursor for first data base */
/*************************************/
exec ("declare db1csr cursor for select name from "+ @db1name + "..sysobjects where type = 'U' and name like  rtrim('"+@tabname+"')  order by name")
open db1csr
fetch db1csr into @db1tab
select @fet1 = @@fetch_status

/**************************************/
/* Set up cursor for second data base */
/**************************************/
exec ("declare db2csr cursor for select name from "+ @db2name + "..sysobjects where type = 'U' and name like  rtrim('"+@tabname+"')  order by name")
open db2csr
fetch db2csr into @db2tab
select @fet2 = @@fetch_status

/***********************/
/* Start Table Compare */
/***********************/
While @fet1 = 0 or @fet2 = 0

begin
  if @fet1 = 0
    select @holdtab1 = @db1tab
  else
    select @holdtab1='zzzzzzzzzzzzzzzzzzz'

  if @fet2 = 0
    select @holdtab2 = @db2tab
  else
    select @holdtab2='zzzzzzzzzzzzzzzzzzz'
  if @fet1 <> 0 or @holdtab1 > @holdtab2
  begin
      select @pointer = '>>'
      select @prtspc,@pointer,@db2tab
  end
  else
  if @fet2 <> 0 or @holdtab2 > @holdtab1
  begin
      select @pointer = '<<'
      select @db1tab,@pointer,@prtspc
  end
  else
  begin
      /*************************************************/
      /* Tables are equal, check for field differences */
      /*************************************************/
      select @pointer = '  '
      --select @db1tab,@pointer,@db2tab
      exec ut_dbcomp_col @db1name ,@db2name ,@db1tab
  end
   /**********************/
  /* Get next record(s) */
  /**********************/
  if @fet1 = 0 and @holdtab1 <= @holdtab2
  begin
     fetch db1csr into @db1tab
     select @fet1 = @@fetch_status
     if @fet1 <> 0
       select @db1tab = ' '
  end

  if @fet2 = 0  and @holdtab2 <= @holdtab1
  begin
     fetch db2csr into @db2tab
     select @fet2 = @@fetch_status
      if @fet2 <> 0
       select @db2tab = ' '
  end

end

/* Clean up cursors */

close db1csr
deallocate db1csr
close db2csr
deallocate db2csr


