 create procedure PJvTran_sFiscal  @parm1 char (6)   as
select * from PJVTRAN
where    fiscalno < @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJvTran_sFiscal] TO [MSDSL]
    AS [dbo];

