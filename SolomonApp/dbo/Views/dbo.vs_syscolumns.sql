 
create view vs_syscolumns as

select id, name = convert(varchar(20), name) from syscolumns


 
