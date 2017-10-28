
create procedure PJPROJ_spk3_w  @parm1 varchar (16)  as
-- This procedure is used by 03.010
SELECT project,gl_subacct from PJPROJ
WHERE    status_pa = 'A' and
status_ap = 'A' and
project = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_spk3_w] TO [MSDSL]
    AS [dbo];

