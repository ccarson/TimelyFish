 create proc ut_tabconvert @tabname char(255)
as
/********************************************************************************
*             Copyright TLB, Inc. 1991, 1994 All Rights Reserved
** Proc Name     : ut_tabconvert
** Narrative     : Creates a template convert in results window
** Inputs        : tabname     ie. APDoc
** Outputs       : Creates a template convert in results window
** Used In       : standalone, called from isql/w window
*
********************************************************************************
* #  Init  Date     Change
********************************************************************************
*001  CLS   08/13/98  Initial Creation
*/

begin transaction

/*                        */
/* make sure table exists */
/*                        */
if not exists (select * from sysobjects where id = object_id(@tabname) and sysstat & 0xf = 3)
  Begin
    select rtrim(@tabname) + ' not found...proc ending.'
    goto abort
  end

/*                        */
/* create temp table      */
/*                        */
select 'insert new create here...change name from tablename to hold_table_name'
select 'insert into hold_'+@tabname
select 'select'
declare @colname varchar (255)
declare c1 cursor  for
select name from syscolumns where id = object_id(@tabname)
open c1
fetch c1 into @colname
while @@fetch_status = 0
begin
select isnull(nullif(rtrim(@colname+','),'tstamp,'),'null')
fetch c1 into @colname
end
close c1
deallocate c1
select rtrim('from '+@tabname)
select rtrim('go')
select rtrim('drop table '+@tabname)
select rtrim('go')
select 'insert new create here...'

select 'insert into '+@tabname
select 'select'
declare c2 cursor  for
select name from syscolumns where id = object_id(@tabname)
open c2
fetch c2 into @colname
while @@fetch_status = 0
begin
select isnull(nullif(rtrim(@colname+','),'tstamp,'),'null')
fetch c2 into @colname
end
close c2
deallocate c2
select 'from hold_'+@tabname
select 'go'
select rtrim('drop table hold_'+@tabname)
commit
goto endit

abort:

rollback
endit:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ut_tabconvert] TO [MSDSL]
    AS [dbo];

