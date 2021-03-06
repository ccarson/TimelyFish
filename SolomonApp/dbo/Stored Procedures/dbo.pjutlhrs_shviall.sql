﻿ create procedure pjutlhrs_shviall @parm1 varchar(1),@parm2 varchar (6) , @parm3 varchar (6), @parm4 varchar(10)     as
select empcode, min(empname),  
/* direct hours */ round(sum(round(pjutlhrs.directhrs,2)),2),  
/* direct % */  CASE WHEN sum(round(pjutlhrs.availhrs,2))=0 then 0 else round(round(sum(round(pjutlhrs.directhrs,2)),2)/round(sum(round(pjutlhrs.availhrs,2)),2),2) * 100 END,  
/* goal % */  CASE WHEN sum(round(pjutlhrs.availhrs,2))=0 then 0 else round(round(sum(round(pjutlhrs.goalhrs,2)),2)/round(sum(round(pjutlhrs.availhrs,2)),2),2) * 100 END,  
/* variance % */ CASE WHEN sum(round(pjutlhrs.availhrs,2))=0 then 0 else round(round(round(sum(round(pjutlhrs.directhrs,2)),2)/round(sum(round(pjutlhrs.availhrs,2)),2),2) * 100 - round(round(sum(round(pjutlhrs.goalhrs,2)),2)/round(sum(round(pjutlhrs.availhrs,2)),2),2) * 100,2) END,  
/* indirect hours */ round(sum(round(pjutlhrs.indirecthrs,2)),2),  
/* available hours */   round(sum(round(pjutlhrs.availhrs,2)),2),  
/* total hours */       round(round(sum(round(pjutlhrs.directhrs,2)),2) + round(sum(round(pjutlhrs.indirecthrs,2)),2),2)  
from pjutlhrs  
where empstatus like @parm1  
 and fiscalno >= @parm2  
 and fiscalno <= @parm3  
 and cpnyid = @parm4  
group by empcode  
order by empcode  



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjutlhrs_shviall] TO [MSDSL]
    AS [dbo];

