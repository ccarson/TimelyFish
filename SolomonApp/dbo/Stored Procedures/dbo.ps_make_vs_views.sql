
/****** Object:  Stored Procedure dbo.ps_make_vs_views    Script Date: 07/06/98 11:38:30 AM ******/
create procedure ps_make_vs_views (@db_name varchar(30), @tabname varchar(50))
as
declare
@newstring  varchar(250)
begin
select @newstring='drop view vs_' + @tabname
exec (@newstring)

select @newstring='create view vs_'+@tabname
 +' as select * from  '+ @db_name
 +'..' + @tabname
print @newstring
exec (@newstring)
end
