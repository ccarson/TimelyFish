 create procedure SLSTAXGRP_sPK0 @parm1 varchar (10)   as
select * from SLSTAXGRP
where GroupID =  @parm1
order by GroupID, TaxID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SLSTAXGRP_sPK0] TO [MSDSL]
    AS [dbo];

