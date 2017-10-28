 


create view vr_20630L3 as
select *,
exception =(CASE 
WHEN   (module ='CA' and (trantype not in ('TR','ZZ') and drcr ='D' or trantype ='TR' and drcr = 'C') or
        module ='AP' or
        module ='PR' or 
        module ='GL' and drcr = 'C') and miss in ('B','C') 
THEN 0
WHEN   (module ='CA' and (trantype not in ('TR','ZZ') and drcr ='C' or trantype ='TR' and drcr = 'D') or
        module ='AR' or
        module ='GL' and drcr = 'D') and miss in ('B','C')
THEN 1
WHEN   (module ='CA' and (trantype not in ('TR','ZZ') and drcr ='D' or trantype ='TR' and drcr = 'C') or --A
        module ='AP' or
        module ='PR' or
        module ='GL' and drcr = 'C') and miss = 'A'
THEN 2
WHEN   (module ='CA' and (trantype not in ('TR','ZZ') and drcr ='C' or trantype ='TR' and drcr = 'D') or
        module ='AR' or
        module ='GL' and drcr = 'D') and miss = 'A'
THEN 3 END)
from vr_20630L2 v
where 
v.miss is not null and 
v.drcr is not null



 
