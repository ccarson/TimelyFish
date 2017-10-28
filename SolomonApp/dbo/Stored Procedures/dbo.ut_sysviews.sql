
create procedure ut_sysviews (@db_name varchar(100) )
as
declare @tabname varchar(100)
declare @declstring varchar(255)
declare @newstring  varchar(250)

select @declstring=
'declare c1 cursor for select substring(name,1,100) from '+@db_name+'.dbo.sysobjects where type = ''u'' '
exec (@declstring)
open c1
fetch c1 into @tabname
while (@@FETCH_STATUS = 0)
begin
  If exists (select * from sysobjects where name = 'vs_'+ @tabname)
  begin
     select @newstring='drop view vs_' + @tabname
     exec (@newstring)
  end 
  select @newstring='create view vs_'+@tabname
    +' as select * from  '+ @db_name
    +'..' + @tabname
  exec (@newstring)
  fetch c1 into @tabname
end
close c1
deallocate c1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ut_sysviews] TO [MSDSL]
    AS [dbo];

