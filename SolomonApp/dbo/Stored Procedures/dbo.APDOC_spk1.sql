 create procedure APDOC_spk1 @parm1 varchar (10) , @parm2 varchar (10)   as
select * from APDOC
where batnbr = @parm1
and refnbr = @parm2
order by batnbr, refnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDOC_spk1] TO [MSDSL]
    AS [dbo];

