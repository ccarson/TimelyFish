

CREATE VIEW [CFV_Genetics]
AS

select genetics_id,longname,sex,disabled,deletion_date
from [$(PigCHAMP)].caredata.GENETICS
--where disabled='0' 
--and deletion_date is null 

