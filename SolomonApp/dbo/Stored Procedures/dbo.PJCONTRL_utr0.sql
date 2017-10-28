 create procedure PJCONTRL_utr0  @parm1 varchar (255)   as
update PJCONTRL
set control_data = @parm1
where
control_type = 'PA' and
control_code = 'TRAN-RUN'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCONTRL_utr0] TO [MSDSL]
    AS [dbo];

