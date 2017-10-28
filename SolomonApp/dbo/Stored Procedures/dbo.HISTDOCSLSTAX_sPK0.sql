 create procedure HISTDOCSLSTAX_sPK0 @parm1 varchar (10) , @PARM2 varchar (6) , @parm3 varchar (2) , @PARM4 varchar (10)   as
select * from HISTDOCSLSTAX
where taxid   = @parm1 and
YrMon   = @parm2 and
DocType = @parm3 and
RefNbr  = @parm4
order by taxid, YrMon, DocType, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[HISTDOCSLSTAX_sPK0] TO [MSDSL]
    AS [dbo];

