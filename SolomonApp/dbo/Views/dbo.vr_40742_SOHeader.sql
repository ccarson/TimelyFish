 

create view vr_40742_SOHeader as
select RI_ID, ShortAnswer00, ShortAnswer01, SOHeader.* 
from SOHeader
cross join RptRuntime
where ReportNbr in ('40742', '40745')

 
