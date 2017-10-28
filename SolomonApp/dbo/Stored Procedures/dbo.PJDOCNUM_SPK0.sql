 Create Procedure PJDOCNUM_SPK0 @parm1 varchar (10) as
Select  *
from     PJdocnum
WHERE ID = @parm1
order by id


