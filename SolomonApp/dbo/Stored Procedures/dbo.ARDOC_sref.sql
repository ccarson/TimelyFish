 create procedure  ARDOC_sref @parm1 varchar (10) , @parm2 varchar (10)   as
select *
from  ARDOC
where ARDOC.batnbr =  @parm1 and
ARDOC.refnbr =  @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDOC_sref] TO [MSDSL]
    AS [dbo];

