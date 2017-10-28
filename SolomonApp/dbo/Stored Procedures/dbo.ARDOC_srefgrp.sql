 create procedure  ARDOC_srefgrp @parm1 varchar (10) , @parm2 varchar (10)   as
select sum(docbal) from ardoc
Where
ardoc.batnbr = @parm1 and
ardoc.refnbr like @parm2
Group by ardoc.batnbr
order by ardoc.batnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDOC_srefgrp] TO [MSDSL]
    AS [dbo];

