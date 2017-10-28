 create procedure APDOC_scount @parm1 varchar (10) , @parm2 varchar (10)   as
select COUNT(*) from APDOC
where APDOC.batnbr = @parm1 and
APDOC.refnbr = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDOC_scount] TO [MSDSL]
    AS [dbo];

