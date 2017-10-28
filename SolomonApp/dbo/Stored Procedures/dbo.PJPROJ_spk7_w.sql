
create procedure PJPROJ_spk7_w  @parm1 varchar (16)  as
select gl_subacct From PJPROJ
where
status_pa = 'A' and
status_LB = 'A' and
project = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_spk7_w] TO [MSDSL]
    AS [dbo];

