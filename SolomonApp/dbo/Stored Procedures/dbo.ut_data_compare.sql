 create proc ut_data_compare @tabname Char(40),@db1name char(40),@db2name Char(40)
as
/********************************************************************************
*            Copyright Solomon Software, Inc. 1994-1998 All Rights Reserved
** Proc Name     : ut_data_compare
** Narrative     : Creates an ouput listing that consists of a data compare
*                 script. The output listings references to database1 and database2
*                 must be changed to the actual databases needing compared. The
*                 can then be cut and pasted into a query window in ISQL_w
*
** Inputs        : tabname  -   table to compare
** Outputs       : Data Comparator script
** Called by     : Isql/W, standalone program
*
********************************************************************************
* #  Init  Date     Change
********************************************************************************
*001  CLS   08/25/98  Initial Creation
*********************************************************************************
*/
declare @textline char     (200)
declare @db1col   char     (38)
declare @db2col   char     (38)
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
declare @i int

Print 'PRINT "*******************************************************"'
Print 'PRINT " records in first database not in second "'
Print 'PRINT "*******************************************************"'

/*** find records from first database not in second ***/
Print 'select *'
--select 'db1.'+rtrim(index_col(@tabname,1,1))
--select @i=2
--while @i < 9
--begin
--if (select index_col(@tabname,1,@i)) is not null
-- begin
-- select ', db1.'+rtrim(index_col(@tabname,1,@i))
-- end
-- select @i=@i+1
--end
Print 'from ' + rtrim(@db1name) +'..'+rtrim(@tabname)+' db1'
print 'where not exists'
print '(select "X" from ' + rtrim(@db2name) +'..'+rtrim(@tabname)+' db2'
print ' where '
select @i=2

Print'db1.'+rtrim(index_col(@tabname,1,1)) + ' = db2.'+index_col(@tabname,1,1)
while @i < 9
begin
if (select index_col(@tabname,1,@i)) is not null
 begin
 Print'and db1.'+rtrim(index_col(@tabname,1,@i)) + ' = db2.'+index_col(@tabname,1,@i)
 end
 select @i=@i+1
end
print ')'
print ' '
print ' '

print 'PRINT "*******************************************************"'
print 'PRINT " records in second database not in first "'
print 'PRINT "*******************************************************"'

/*** find records from first database not in second ***/
print 'select *'
--select 'db2.'+rtrim(index_col(@tabname,1,1))
--select @i=2
--while @i < 9
--begin
--if (select index_col(@tabname,1,@i)) is not null
-- begin
-- select ', db2.'+rtrim(index_col(@tabname,1,@i))
-- end
-- select @i=@i+1
--end
Print 'from ' + rtrim(@db2name) +'..'+rtrim(@tabname)+' db2'
print 'where not exists'
Print'(select "X" from ' + rtrim(@db1name) +'..'+rtrim(@tabname)+' db1'
print ' where '
select @i=2

Print'db1.'+rtrim(index_col(@tabname,1,1)) + ' = db2.'+index_col(@tabname,1,1)
while @i < 9
begin
if (select index_col(@tabname,1,@i)) is not null
 begin
 Print'and db2.'+rtrim(index_col(@tabname,1,@i)) + ' = db1.'+index_col(@tabname,1,@i)
 end
 select @i=@i+1
end
print ')'
print ' '
print ' '
/***** Now build check for different records ***/

print 'PRINT "*******************************************************"'
print 'PRINT " records that differ between first and second database "'
print 'PRINT "*******************************************************"'

/*************************************/
/* Set up cursor table columns       */
/*************************************/
exec ("declare db1csrcol cursor for select sc.name from syscolumns sc,
                                        sysobjects so where so.id = sc.id and so.name ='"+@tabname+"'  order by sc.name")
open db1csrcol
fetch db1csrcol into @db1col
select @fet1 = @@fetch_status

/***build select from both databases.... ***/

print "select '  ',db1.* , char(10), '',db2.* ,char(10),'-------------------------------------------'"
Print "from "+rtrim(rtrim(@db1name) +'..'+@tabname)+" db1"
Print "    ,"+rtrim(rtrim(@db2name) +'..'+@tabname)+" db2"
print ' where'

select @i=2

/*** ...where primary keys are equal... ***/

print '('
Print 'db1.'+rtrim(index_col(@tabname,1,1)) + ' = db2.'+index_col(@tabname,1,1)
while @i < 9
begin
if (select index_col(@tabname,1,@i)) is not null
 begin
 Print 'and db1.'+rtrim(index_col(@tabname,1,@i)) + ' = db2.'+index_col(@tabname,1,@i)
 end
 select @i=@i+1
end
print ')'

/*** ...and any other fields are not equal ***/

print 'and'
print '('
Print rtrim('db1.'+@db1col)+ rtrim(' <> db2.'+@db1col)
    fetch db1csrcol into @db1col
While @@fetch_status = 0
begin
    Print 'or '+rtrim('db1.'+@db1col)+ rtrim(' <> db2.'+@db1col)
    fetch db1csrcol into @db1col
end
print ')'
/* Clean up cursors */

close db1csrcol
deallocate db1csrcol



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ut_data_compare] TO [MSDSL]
    AS [dbo];

