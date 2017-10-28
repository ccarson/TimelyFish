 

create view vr_40742_SOEvent as
select *, ShortAnswer00 = convert(char(10),'True') from SOEvent


 
