 create procedure  ARDOC_sdoctype @parm1 varchar (2) , @parm2 varchar (10)   as
select *
from  ARDOC
where ARDOC.doctype =  @parm1
and ARDOC.refnbr like @parm2
	order by refnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDOC_sdoctype] TO [MSDSL]
    AS [dbo];

